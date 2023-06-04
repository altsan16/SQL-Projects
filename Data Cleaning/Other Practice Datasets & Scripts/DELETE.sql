/* DELETE
*/

SELECT * FROM responses
ORDER BY r_id

--Deletes row with r_id 215

DELETE FROM responses
WHERE r_id = 215
RETURNING *;
--Returns the deleted/affected rows
--WHERE clause indicates the conditions or to specify which rows to delete, if WHERE clause is not included, all rows are deleted