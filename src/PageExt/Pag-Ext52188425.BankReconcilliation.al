pageextension 50017 "Bank Statement" extends "Bank Account Statement List"
{


    layout
    {


    }



    actions
    {
        // Adding a new action group 'MyNewActionGroup' in the 'Creation' area
        addbefore(Print)
        {


            action(ReconReport)
            {
                ApplicationArea = Basic, Suite;
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Recon: Record "Posted Bank Rec";
                begin
                    CurrPage.Update;
                    Recon.Reset();
                    Recon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    Recon.SetRange("Statement No.", Rec."Statement No.");
                    if Recon.FindFirst() then begin
                        Report.Run(Report::"Bank Acc. Recon. Posted", true, false, recon);
                    end;
                end;
            }

        }
    }
}
