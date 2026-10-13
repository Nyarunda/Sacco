
Report 50164 "Update Emp Pics"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Update Emp Pics.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*Cust.RESET;
                Cust.SETRANGE("No.",Employee."Member No");
                IF Cust.FIND('-') THEN BEGIN
                   Employee."First Name":=Cust."First Name";
                   Employee."Middle Name":=Cust."Middle Name";
                   Employee."Last Name":=Cust.Surname;
                   Employee."Search Name":=Cust.Name;
                   Employee."National Id":=Cust."ID No.";
                   //Employee.Id:=Cust."ID No.";
                   Employee."Phone No.":=Cust."Mobile Phone No.";
                   Employee."Birth Date":=Cust."Date of Birth";
                
                
                   Employee.MODIFY;
                
                END;*/

                //IF Members."No."='0002883' THEN CurrReport.SKIP;
                //MyString:=Employee."Search Name";
                /* IF Cust.GET(Employee."Member No")THEN BEGIN
                   Employee."Search Name":=Cust.Name;
                   Employee.MODIFY;
                   END;*/

                MyString := Employee."Search Name";
                String1 := '';  // Returns 'ABC' and changes string to '111-124'
                String2 := '';  // Returns '111' and changes string to '124'
                String3 := '';
                String4 := '';
                String5 := '';


                String1 := Token(MyString, ' ');  // Returns 'ABC' and changes string to '111-124'
                String2 := Token(MyString, ' ');  // Returns '111' and changes string to '124'
                String3 := Token(MyString, ' ');
                String4 := Token(MyString, ' ');
                String5 := Token(MyString, ' ');

                //Employee."First Name":=Employee."Search Name";
                //Employee."Last Name":='';

                Employee."First Name" := String1;
                //Employee."Middle Name":=String2;
                Employee."Last Name" := String2;

                Employee.Modify;

            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Cust: Record Members;
        Names: Text;
        Name1: Text;
        Name2: Text;
        Name3: Text;
        WorkString: Text;
        Pos: Integer;
        String1: Text;
        String2: Text;
        String3: Text;
        String4: Text;
        String5: Text;
        MyString: Text;


    procedure Token(var Text: Text[100]; Separator: Text[1]) Token: Text[100]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, Separator);

        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;
}

