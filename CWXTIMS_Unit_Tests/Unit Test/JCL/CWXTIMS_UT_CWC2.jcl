//HDDRXM0B JOB ('EUDD,INTL'),'NUESSE',NOTIFY=&SYSUID,  
//             MSGLEVEL=(1,1),MSGCLASS=X,CLASS=A,REGION=0M
//*
/*JOBPARM S=CWC2  
//*** SPECIFY JOBCARD IN TOTALTEST PREFERENCES TO SUBSTITUTE 
//***    
//*** THE JOB CARD MUST INCLUDE A NOTIFY STATEMENT SUCH  
//*** AS NOTIFY=&SYSUID AND ALSO A REGION=0M PARAMETER 
//*   
//********************************************************************
//* EXECUTE TARGET RUNNER      
//********************************************************************
//RUNDLI EXEC PGM=DFSRRC00,REGION=4096K,
//         PARM=(DLI,TTTRUNNR,XIXPSBSA,8,0000,,0,,N,0,T,,,N)
//* THE PARM STRING ABOVE SHOULD BE TAKEN FROM YOUR STANDARD JCL 
//*  THAT EXECUTES THE TARGET PROGRAM, BUT WITH THE SECOND PARAMETER  
//*  REPLACED WITH TTTRUNNR.  ALL OTHER PARAMETERS SHOULD BE COPIED
//*  FROM THE NORMAL JCL USED TO EXECUTE THE TARGET PROGRAM.
//*                             
//* YOU NEED TO MODIFY THE FOLLOWING DD STATEMENTS.
//*                                 
//* THE STEPLIB CONCATENATION SHOULD INCLUDE THE LOADLIB 
//* CONTAINING THE TOPAZ FOR TOTAL TEST 'TTTRUNNR' PROGRAM 
//* AND THE COBOL RUNTIME(CEE.SCEERUN) AND ALL LOAD LIBRARIES
//* NEEDED IN SUPPORT OF THE IMS BMP TARGET PROGRAM. 
//* CONTAINING THE PROGRAMS TO RUN DURING THE TEST.  
//*                                     
//* THE SECOND DD STATEMENT IS ONLY REQUIRED IF RUNNING THE JCL 
//* FROM TOPAZ FOR TOTAL TEST CLI WITH CODE COVERAGE SUPPORT.
//* IF TESTING AN LE APPLICATION IT SHOULD BE CHANGED TO THE 
//* LOADLIB CONTAINING THE COBOL RUNTIME(CEE.SCEERUN), OTHERWISE 
//* IT CAN BE REMOVED.
//STEPLIB  DD DISP=SHR,DSN=SYS2.CW.&CWGACX..SLCXLOAD
//         DD DISP=SHR,DSN=IMS141A.CWC2.SDFSRESL
//         DD DISP=SHR,DSN=IMS141A.SDFSRESL
//         DD DISP=SHR,DSN=HDDRXM0.DEMO.LOAD.PDSE
//         DD DISP=SHR,DSN=CEE.SCEERUN
//DFSRESLB DD  DISP=SHR,DSN=IMS141A.CWC2.SDFSRESL
//         DD  DISP=SHR,DSN=IMS141A.SDFSRESL
//IMS      DD  DISP=SHR,DSN=IX.IMS131A.DBDLIB
//         DD  DISP=SHR,DSN=IX.IMS131A.PSBLIB
//         DD  DISP=SHR,DSN=HDDRXM0.FISAMP.DBDLIB
//DFSVSAMP DD  DISP=SHR,DSN=IMS141A.CWC2.PROCLIB(DFSVSMDC)
//IEFRDER  DD  DUMMY
//*    
//SYSUDUMP DD SYSOUT=*        
//TRPARM DD *   
*             
*        OPTIONALLY SET YOUR CUSTOM EXIT PROGRAM HERE: 
*                        
EXIT(NONE)    
*               
REPEAT(${TOTALTEST_REPEAT}),STUBS(${TOTALTEST_STUBS}),
ARGTYPE(IMSMAIN), 
DEBUG(OFF) 
/*                                      
//BININP DD DSN=${TOTALTEST_BININP},DISP=OLD
//BINREF DD DSN=${TOTALTEST_BINREF},DISP=OLD
//BINRES DD DSN=${TOTALTEST_BINRES},DISP=OLD