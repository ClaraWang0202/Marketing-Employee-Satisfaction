FILENAME REFFILE '/home/u38758449/Markerting Project-employee satisfaction/EmployeeSatisfactionData.csv';
options VALIDVARNAME=V7;
PROC IMPORT DATAFILE=REFFILE	DBMS=CSV	OUT=WORK.EmployeeData replace;
	GETNAMES=YES;
     MIXED=NO;
RUN;

proc contents data=EmployeeData;
run;

proc sql;
update EmployeeData 
set Status = 
       case
       when Status CONTAINS  'Former' then 'Former'
       else 'Current'
       end;
run;


proc freq data=EmployeeData;
table Status;
run;

data EmployeeData;
modify  EmployeeData ;
if Type_of_Job ="Unknown" then remove ;



proc freq data=EmployeeData;
table Type_of_Job;
run;

proc stdize data=EmployeeData out=EmployeeDataScale method=SUM;
   var 	
Cons_Growth___career_development
Cons_Job_design	
Cons_Management_support
Cons_Organizational_structure__	
Cons_Tech___resources
Cons_Work_environment
Cons_Workspace_design
Cons_Compensation___rewards
Firm_reputation
Growth___career_development
Job_design
Management_support
Work_environment
Workspace_design
Tech___resources
Compensation___rewards	;
run;




proc glm data=EmployeeDataScale;

     
     class Company_ID  Size__Number_of_employees_ 
     Year Quarter Industry ProductService Status Type_of_Job(ref="BackOffice");
     
     model Rating__Overall_ =
     Size__Number_of_employees_ 
     Quarter 
     Status 
     Company_ID 
     Year
     Type_of_Job
     Industry 
     
     Cons_Growth___career_development
     Cons_Job_design	
     Cons_Management_support
     Cons_Organizational_structure__
     Cons_Work_environment
     Cons_Workspace_design	
     Cons_Tech___resources
     Cons_Compensation___rewards
     Firm_reputation
     Growth___career_development	
     Job_design
     Management_support		
     Work_environment
     Tech___resources
     Workspace_design
     Compensation___rewards
     
     Cons_Growth___career_development*Type_of_Job
     Cons_Job_design*Type_of_Job	
     Cons_Management_support*Type_of_Job
     Cons_Organizational_structure__*Type_of_Job
     Cons_Work_environment*Type_of_Job
     Cons_Workspace_design*Type_of_Job	
     Cons_Tech___resources*Type_of_Job
     Cons_Compensation___rewards*Type_of_Job
     Firm_reputation*Type_of_Job
     Growth___career_development*Type_of_Job	
     Job_design*Type_of_Job
     Management_support*Type_of_Job		
     Work_environment*Type_of_Job
     Tech___resources*Type_of_Job
     Workspace_design*Type_of_Job
     Compensation___rewards*Type_of_Job
     
     Cons_Growth___career_development*Industry
     Cons_Job_design*Industry	
     Cons_Management_support*Industry
     Cons_Organizational_structure__*Industry
     Cons_Work_environment*Industry
     Cons_Workspace_design*Industry	
     Cons_Tech___resources*Industry
     Cons_Compensation___rewards*Industry
     Firm_reputation*Industry
     Growth___career_development*Industry	
     Job_design*Industry
     Management_support*Industry		
     Work_environment*Industry
     Tech___resources*Industry
     Workspace_design*Industry
     Compensation___rewards*Industry/solution ;

run;