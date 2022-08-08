--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
LANGUAGE SQL                       
MODIFIES SQL DATA                      

BEGIN 

	DECLARE SQLCODE INTEGER DEFAULT 0;                  -- Host variable SQLCODE declared and assigned 0
	DECLARE retcode INTEGER DEFAULT 0;                  -- Local variable retcode with declared and assigned 0
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION           -- Handler tell the routine what to do when an error or warning occurs
    	SET retcode = SQLCODE;    
         
	UPDATE CHICAGO_PUBLIC_SCHOOLS_DATA
	SET  Leaders_Score = in_Leader_Score
	WHERE School_ID = in_School_ID;
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS_DATA
		SET  Leaders_Icon = 'Very weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS_DATA
		SET  Leaders_Icon = 'Weak'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score < 60 THEN		
		UPDATE CHICAGO_PUBLIC_SCHOOLS_DATA
		SET  Leaders_Icon = 'Average'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score < 80 THEN		
		UPDATE CHICAGO_PUBLIC_SCHOOLS_DATA
		SET  Leaders_Icon = 'Strong'
		WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score < 100 THEN	
		UPDATE CHICAGO_PUBLIC_SCHOOLS_DATA
		SET  Leaders_Icon = 'Very strong'
		WHERE School_ID = in_School_ID;
	ELSE
	END IF; 
	
	IF retcode < 0 THEN                                  --  SQLCODE returns negative value for error, zero for success, positive value for warning
		ROLLBACK WORK;
	ELSE
		COMMIT WORK;
    	END IF;
END
@