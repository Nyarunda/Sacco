
PageExtension 50116 pageextension50116 extends "Employee List"
{

    //Unsupported feature: Property Insertion (SourceTableView) on ""Employee List"(Page 5201)".

    layout
    {
        addafter("Post Code")
        {
            field("Member No"; Rec."Member No")
            {
                ApplicationArea = Basic;
                LookupPageID = "Member Listing";
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        addafter(PayEmployee)
        {
            action("Update Staff Accounts")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    i: Integer;
                    j: Integer;
                    k: Integer;
                    Loans: Record Loans;
                begin
                    if Confirm('Are you sure you want to update Staff Accounts?') then begin
                        i := 0;
                        j := 0;
                        k := 0;
                        Members.Reset;
                        Members.SetRange("Member Category", Members."Member Category"::"Staff Members");
                        if Members.FindFirst then begin
                            repeat
                                i += 1;

                                Members."Employer Code" := '';
                                Employee.Reset;
                                Employee.SetRange("Member No", Members."No.");
                                if Employee.FindFirst then begin
                                    if Employee.Status = Employee.Status::Active then begin
                                        k += 1;

                                        //Members."Employer Code" := 'SACCOSTAFF';
                                    end
                                    else begin
                                        j += 1;
                                    end;
                                end
                                else
                                    j += 1;

                                Members.Modify;
                            until Members.Next = 0;
                        end;
                    end;




                    Message('Total %1\Inactive %2\Active %3', i, j, k);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not CurrPage.LookupMode then
            RestrictDirectEmployeeListAccess();
    end;

    local procedure RestrictDirectEmployeeListAccess()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();
    end;

    var
        Members: Record Members;
        Employee: Record Employee;
}
