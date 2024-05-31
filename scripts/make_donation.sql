CREATE TABLE donation AS
SELECT
    committees.name AS committee_name,
    strftime ('%Y-%m-%d', received_date) AS received_date,
    amount,
    CASE WHEN first_name IS NOT NULL THEN
        first_name || ' ' || last_name
    ELSE
        last_name
    END AS name,
    occupation,
    employer,
    receipts.city || ', ' || receipts.state || ' ' || receipts.zipcode AS city_state_zip
FROM
    receipts
    INNER JOIN committees ON committee_id = committees.id
WHERE
    received_date >= '2023-01-01'
    AND archived = 0
