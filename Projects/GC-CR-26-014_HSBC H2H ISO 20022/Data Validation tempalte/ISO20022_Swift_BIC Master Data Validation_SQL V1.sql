WITH SUPPLIER_DIVISIONS AS
(
    /* One row per Payee + Division from the AP sub ledger (last 3 years) */
    SELECT
        CONO                         AS company,
        DIVI                         AS division,
        SPYN                         AS supplier_no,
        MAX(YEA4)                    AS last_year,
        MAX(ACDT)                    AS last_acct_date,
        COUNT(*)                     AS txn_count
    FROM FPLEDG
    WHERE CONO = 100
      AND DIVI IN ('001')
      AND YEA4 >= 2023
      AND SPYN IS NOT NULL
      AND TRIM(SPYN) <> ''
    GROUP BY CONO, DIVI, SPYN
),

ADDRESS_RANKED AS
(
    /* Priority: type 10 (Bank) first, then type 01 (Postal) */
    SELECT
        CONO, SUNO, ADTE, ADID,
        SUNM, ADR1, ADR2, ADR3, ADR4,
        PONO, TOWN, ECAR, CSCD,
        ROW_NUMBER() OVER
        (
            PARTITION BY CONO, SUNO
            ORDER BY
                CASE
                    WHEN CAST(ADTE AS INTEGER) = 10 THEN 1
                    WHEN CAST(ADTE AS INTEGER) = 1  THEN 2
                END,
                STDT DESC,
                ADID
        ) AS rn
    FROM CIDADR
    WHERE CONO = 100
      AND CAST(ADTE AS INTEGER) IN (1, 10)
),

SELECTED_ADDRESS AS
(
    SELECT * FROM ADDRESS_RANKED WHERE rn = 1
),

BANK_ACCOUNTS AS
(
    SELECT
        CONO, DIVI, ACHO, BKID, BKTP, BKIN,
        BKNO, BANA, BACN, IBAN, CUCD, STAT,
        UPPER(TRIM(BAF4))            AS bic_clean,
        TRIM(BAF4)                   AS bic_raw,
        TRIM(SWBI)                   AS swbi_raw
    FROM CBANAC
    WHERE CONO = 100
      AND BKIN = 'INTG'
      AND STAT = '20'
),

BIC_CHECK AS
(
    SELECT
        B.*,
        CASE
            WHEN B.bic_clean IS NULL OR B.bic_clean = ''
                THEN 'INVALID - BIC Missing'

            WHEN B.bic_clean LIKE '% %'
                THEN 'INVALID - Contains Spaces'

            WHEN LENGTH(B.bic_clean) NOT IN (8, 11)
                THEN 'INVALID - Incorrect Length'

            WHEN B.bic_raw <> B.bic_clean
                THEN 'INVALID - Lowercase Characters'

            /* Positions 1-6 must be A-Z, positions 7-8 must be A-Z or 0-9 */
            WHEN NOT (
                    SUBSTR(B.bic_clean, 1, 1) BETWEEN 'A' AND 'Z'
                AND SUBSTR(B.bic_clean, 2, 1) BETWEEN 'A' AND 'Z'
                AND SUBSTR(B.bic_clean, 3, 1) BETWEEN 'A' AND 'Z'
                AND SUBSTR(B.bic_clean, 4, 1) BETWEEN 'A' AND 'Z'
                AND SUBSTR(B.bic_clean, 5, 1) BETWEEN 'A' AND 'Z'
                AND SUBSTR(B.bic_clean, 6, 1) BETWEEN 'A' AND 'Z'
                AND (SUBSTR(B.bic_clean, 7, 1) BETWEEN 'A' AND 'Z'
                     OR SUBSTR(B.bic_clean, 7, 1) BETWEEN '0' AND '9')
                AND (SUBSTR(B.bic_clean, 8, 1) BETWEEN 'A' AND 'Z'
                     OR SUBSTR(B.bic_clean, 8, 1) BETWEEN '0' AND '9')
            )
                THEN 'INVALID - Invalid Characters/Format'

            /* Optional branch code (positions 9-11) must be A-Z or 0-9 */
            WHEN LENGTH(B.bic_clean) = 11 AND NOT (
                    (SUBSTR(B.bic_clean, 9, 1) BETWEEN 'A' AND 'Z'
                     OR SUBSTR(B.bic_clean, 9, 1) BETWEEN '0' AND '9')
                AND (SUBSTR(B.bic_clean, 10, 1) BETWEEN 'A' AND 'Z'
                     OR SUBSTR(B.bic_clean, 10, 1) BETWEEN '0' AND '9')
                AND (SUBSTR(B.bic_clean, 11, 1) BETWEEN 'A' AND 'Z'
                     OR SUBSTR(B.bic_clean, 11, 1) BETWEEN '0' AND '9')
            )
                THEN 'INVALID - Invalid Branch Code'

            WHEN LENGTH(B.bic_clean) = 11 AND SUBSTR(B.bic_clean, 9, 3) = 'XXX'
                THEN 'INVALID - Dummy Branch Code (XXX)'

            ELSE 'VALID'
        END AS bic_status
    FROM BANK_ACCOUNTS B
)

SELECT
    /* ---------- Identification ---------- */
    B.CONO                           AS "Company",
    SD.division                      AS "Division",
    B.ACHO                           AS "Supplier Number",
    SA.SUNM                          AS "Supplier Name",
    COUNT(*) OVER (PARTITION BY B.CONO, B.ACHO, B.BKID)
                                     AS "Divisions Used (In Scope)",
    SD.last_year                     AS "Last AP Activity Year",
    SD.last_acct_date                AS "Last AP Accounting Date",
    SD.txn_count                     AS "AP Transaction Count",

    /* ---------- Bank account ---------- */
    B.BKID                           AS "Bank Account ID",
    B.BKIN                           AS "Bank Account Indicator",
    B.BKTP                           AS "Bank Account Type Code",
    B.BANA                           AS "Bank Account Name",
    B.BKNO                           AS "Bank Number",
    B.BACN                           AS "Bank Account Number",
    B.IBAN                           AS "IBAN",
    B.CUCD                           AS "Account Currency",
    B.DIVI                           AS "Bank Master Division",

    /* ---------- BIC validation ---------- */
    B.bic_raw                        AS "SWIFT/BIC (BAF4)",
    B.swbi_raw                       AS "SWIFT/BIC (SWBI field)",
    LENGTH(B.bic_raw)                AS "BIC Length",
    B.bic_status                     AS "BIC Validation Status",

    /* ---------- Address ---------- */
    CASE
        WHEN SA.SUNO IS NULL                    THEN 'No Address Found'
        WHEN CAST(SA.ADTE AS INTEGER) = 10      THEN '10 - Bank Address'
        WHEN CAST(SA.ADTE AS INTEGER) = 1       THEN '01 - Postal Address'
    END                              AS "Address Source",
    SA.ADR1                          AS "Address Line 1",
    SA.ADR2                          AS "Address Line 2",
    SA.ADR3                          AS "Address Line 3",
    SA.ADR4                          AS "Address Line 4",
    SA.PONO                          AS "Postal Code",
    SA.TOWN                          AS "Town/City",
    SA.ECAR                          AS "State",
    SA.CSCD                          AS "Country",

    CASE
        WHEN SA.SUNO IS NULL
            THEN 'INVALID - No Address Found'
        WHEN SA.TOWN IS NULL OR TRIM(SA.TOWN) = ''
            THEN CASE WHEN SA.CSCD IS NULL OR TRIM(SA.CSCD) = ''
                      THEN 'INVALID - Town/City and Country Missing'
                      ELSE 'INVALID - Town/City Missing' END
        WHEN SA.CSCD IS NULL OR TRIM(SA.CSCD) = ''
            THEN 'INVALID - Country Missing'
        ELSE 'VALID'
    END                              AS "Address Validation Status",

    /* ---------- Combined flag for easy filtering ---------- */
    CASE
        WHEN B.bic_status = 'VALID'
         AND SA.SUNO IS NOT NULL
         AND TRIM(COALESCE(SA.TOWN, '')) <> ''
         AND TRIM(COALESCE(SA.CSCD, '')) <> ''
            THEN 'PASS'
        ELSE 'REVIEW'
    END                              AS "Overall Review Status"

FROM BIC_CHECK B

INNER JOIN SUPPLIER_DIVISIONS SD
    ON  SD.company     = B.CONO
    AND SD.supplier_no = B.ACHO

LEFT JOIN SELECTED_ADDRESS SA
    ON  SA.CONO = B.CONO
    AND SA.SUNO = B.ACHO

ORDER BY
    SD.division,
    B.ACHO,
    B.BKID;