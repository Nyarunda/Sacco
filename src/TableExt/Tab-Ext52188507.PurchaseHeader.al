
TableExtension 50170 tableextension52188407 extends "Purchase Header"
{



    fields
    {
        field(50000; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Order Posting Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Frozen,UnFrozen;
        }
        field(50003; "Frozen By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "UnFrozen By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(50009; "Procurement Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Invoice Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "PO Based","Direct Invoice";
        }
    }


    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        UserSetup.TestField("Dimension Set ID");
        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Dimension Set ID" := UserSetup."Dimension Set ID";
    end;


    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";
    begin
        "Posting Description" := '';
    end;



    //    OnAfterInitPostingNoSeries(Rec, xRec);



}
