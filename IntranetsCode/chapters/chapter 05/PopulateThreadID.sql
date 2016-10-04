-- Clear out any existing ThreadId values (just in case)
UPDATE
    Discussion
SET
    ThreadID = NULL


-- Set the ThreadId values for the top level messages
UPDATE 
    Discussion
SET
    ThreadID = ItemID
WHERE
    Len(DisplayOrder) <= 23


-- Set the ThreadID values for the replies
UPDATE
    Discussion
SET
    ThreadID = (SELECT
                    Threads.ThreadID 
                FROM
                    Discussion Threads
                WHERE
                    LEFT(Discussion.DisplayOrder, 23) = Threads.DisplayOrder
                    AND Threads.ThreadID IS NOT NULL)
WHERE
    LEN(Discussion.DisplayOrder) > 23
