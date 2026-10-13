report 50379 "Modify NextofKin Details"
{
    ApplicationArea = All;
    Caption = 'Modify NextofKin Details';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(NextofKin; Customer)
        {

            trigger OnAfterGetRecord()
            var
                Emp: Record Employee;
                NOK: Record "Next of Kin.";
                Cust: Record Members;
            begin
                Cust.Reset();
                // Cust.SetRange("Member Category", Cust."Member Category"::"Staff Members");
                if Cust.FindFirst() then begin
                    NOK.Reset();
                    NOK.SetRange("No.", Cust."No.");


                    // NOK.SetRange("ID No.", Emp."Personal ID No.");
                    if NOK.FindFirst() then begin
                        repeat
                            NOK."Employee No." := Cust."Payroll/Staff No.";
                            NOK.Modify();

                        until NOK.next = 0;
                    end;

                end;

                /* Emp.Reset();
                 Emp.SetRange("Personal ID No.", "ID No.");
                 if not Emp.FindFirst() then CurrReport.Skip();
                 begin
                     NOK.Reset();
                     NOK.SetRange("ID No.", Emp."Personal ID No.");
                     if NOK.FindFirst() then begin
                         repeat
                             NOK."Employee No." := Emp."No.";
                             NOK.Modify();
                         until NOK.next = 0;
                     end;

                 end;*/
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
