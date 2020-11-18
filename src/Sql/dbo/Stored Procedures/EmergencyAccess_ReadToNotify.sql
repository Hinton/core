﻿CREATE PROCEDURE [dbo].[EmergencyAccess_ReadToNotify]
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        EA.*,
        Grantee.Name as GranteeName,
        Grantor.Email as GrantorEmail
    FROM
        [dbo].[EmergencyAccess] EA
    LEFT JOIN
        [dbo].[User] Grantor ON Grantor.[Id] = EA.[GrantorId]
    LEFT JOIN
        [dbo].[User] Grantee On Grantee.[Id] = EA.[GranteeId]
    WHERE
        EA.[Status] = 3
    AND
        DATEADD(DAY, EA.[WaitTimeDays] - 1, EA.[RecoveryInitiatedAt]) <= GETDATE()
    AND
        DATEADD(DAY, 1, EA.[LastNotificationAt]) <= GETDATE()
END