
Report 50169 "Update Staff Portfolio"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Officer; Officer)
                {
                    ApplicationArea = Basic;
                    TableRelation = Employee;
                }
                field("New Branch"; NewBranch)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                }
                field("From Officer"; FromOfficer)
                {
                    ApplicationArea = Basic;
                    TableRelation = Employee;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if Officer = '' then
            Error('Enter Officer No.');

        if NewBranch = '' then
            Error('Enter New Branch');


        if FromOfficer = '' then
            Error('Enter From Officer No.');

        Members.Reset;
        Members.SetRange("Global Dimension 2 Code", NewBranch);
        Members.SetFilter("Relationship Officer", FromOfficer);
        if Members.FindFirst then begin
            repeat
                Members.Validate("Relationship Officer", Officer);
                Members.Modify;
            until Members.Next = 0;
        end;
        Message('Successfully Updated');
    end;

    var
        Officer: Code[20];
        NewBranch: Code[20];
        Employee: Record Employee;
        Members: Record Members;
        FromBranch: Code[20];
        FromOfficer: Code[20];
}

