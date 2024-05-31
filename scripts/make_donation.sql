CREATE TABLE donation AS
SELECT
    committees.name AS committee_name,
    strftime ('%Y-%m-%d', received_date) AS received_date,
    amount,
    CASE WHEN d2_part = '1A' THEN
        'individual contribution'
    WHEN d2_part = '2A' THEN
        'transfer'
    WHEN d2_part = '3A' THEN
        'loan'
    WHEN d2_part = '4A' THEN
        'other receipts'
    WHEN d2_part = '5A' THEN
        'in-kind'
    END AS type,
    CASE WHEN first_name IS NOT NULL THEN
        first_name || ' ' || last_name
    ELSE
        last_name
    END AS name,
    occupation,
    employer,
    receipts.city || ', ' || receipts.state || ' ' || receipts.zipcode AS city_state_zip,
    filed_doc_id,
    doc_name
FROM
    receipts
    INNER JOIN committees ON receipts.committee_id = committees.id
    INNER JOIN filed_docs ON filed_doc_id = filed_docs.id
WHERE
    received_date >= '2023-01-01'
    AND receipts.archived = 0;
