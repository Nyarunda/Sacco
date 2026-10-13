page 50397 "Loans Approved List"
{
    Caption = 'Loans Approved List';
    ApplicationArea = Basic;
    CardPageID = "Loan Appraisal Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    SourceTableView = where(Status = const(Approved), "Loan Stage" = filter("Loan Appraisal"),"Appraisal Completed"=const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Appraisal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApprovedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(MemberName; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {

        // area(navigation)
        // {
        //     action("Create Batch")
        //     {
        //         ApplicationArea = Suite;
        //         Image = Document;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;

        //         trigger OnAction()
        //         var
        //             LRec: Record Loans;
        //             Batch: Record "Loan Disbursement Header";
        //             DisbLines: Record "Loan Disbursement Lines";
        //             Loans: Record Loans;
        //             EntryNo: Integer;
        //         begin
        //             LRec.Reset();
        //             LRec.SetRange(Select, true);
        //             LRec.SetRange("Selected By", UserId);
        //             LRec.SetRange(Status, Rec.Status::Approved);
        //             LRec.SetRange(Posted, false);
        //             LRec.SetRange("Batch No.", '');
        //             if LRec.FindFirst() then begin
        //                 if Confirm('Are you sure you want to batch then selected ' + Format(LRec.Count) + 'loan(s)?') then begin
        //                     Batch.Init();
        //                     Batch."No." := '';
        //                     Batch.Insert(true);
        //                     repeat
        //                         LRec."Batch No." := Batch."No.";
        //                         Lrec.Select := false;
        //                         LRec."Selected By" := '';
        //                         LRec.Modify();
        //                     until LRec.Next() = 0;


        //                     //Validations
        //                     DisbLines.Reset;
        //                     DisbLines.SetRange(DisbLines.No, Rec."Batch No.");
        //                     if DisbLines.Find('-') then begin
        //                         DisbLines.DeleteAll;
        //                     end;
        //                     Loans.Reset;
        //                     //Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
        //                     Loans.SetRange(Loans.Posted, false);
        //                     Loans.SetRange(Loans."Batch No.", Rec."Batch No.");
        //                     if Loans.Find('-') then begin
        //                         repeat

        //                             EntryNo := EntryNo + 1000;
        //                             DisbLines.Init;
        //                             DisbLines."Line No." := EntryNo;
        //                             DisbLines."Loan No." := Loans."Loan No.";
        //                             DisbLines.Validate(DisbLines."Loan No.");
        //                             DisbLines."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
        //                             DisbLines."Global Dimension 2 Code" := Loans."Booking Branch";
        //                             DisbLines.No := Rec."Batch No.";
        //                             DisbLines.Insert;
        //                         //Tag that it has been suggested
        //                         //Loans."Already Suggested":=TRUE;
        //                         //Loans.MODIFY;
        //                         until Loans.Next = 0;
        //                     end;

        //                 end;
        //             end;
        //         end;
        //     }
        //     action("OPen Batch")
        //     {
        //         ApplicationArea = Suite;
        //         Image = Document;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         trigger OnAction()
        //         var
        //             LRec: Record Loans;
        //             Batch: Record "Loan Disbursement Header";
        //         begin
        //             Rec.TestField("Batch No.");
        //             Batch.Reset();
        //             Batch.SetRange("No.", Rec."Batch No.");
        //             if Batch.FindFirst() then
        //                 page.Run(50288, Batch);

        //         end;
        //     }
        //     action("Remove Batch No.")
        //     {
        //         ApplicationArea = Suite;
        //         Image = Document;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         trigger OnAction()
        //         var
        //             LRec: Record Loans;
        //             Batch: Record "Loan Disbursement Header";
        //         begin
        //             Rec."Batch No." := '';
        //             Rec.Select := false;
        //             Rec."Selected By" := '';
        //             Rec.Modify();

        //         end;
        //     }
        //     action("Remove Batch")
        //     {
        //         ApplicationArea = Suite;
        //         Image = Document;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         trigger OnAction()
        //         var
        //             LRec: Record Loans;
        //             Batch: Record "Loan Disbursement Header";
        //         begin
        //             LRec.Reset();
        //             LRec.SetRange(Select, true);
        //             LRec.SetRange("Selected By", UserId);
        //             LRec.SetRange(Status, Rec.Status::Approved);
        //             LRec.SetRange(Posted, false);
        //             LRec.SetFilter("Batch No.", '<>%1', '');
        //             if LRec.FindFirst() then begin
        //                 if Confirm('Are you sure you want to unbatch then selected ' + Format(LRec.Count) + 'loan(s)?') then begin
        //                     repeat
        //                         LRec."Batch No." := '';
        //                         Lrec.Select := false;
        //                         LRec."Selected By" := '';
        //                         LRec.Modify();
        //                     until LRec.Next() = 0;

        //                     Message('Process Completed Successfully', Batch."No.");

        //                 end;
        //             end;
        //         end;
        //     }
        // }
    }

   
}

