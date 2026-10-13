
Table 50257 "RFQ Vendors"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Requisition Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor where("Vendor Posting Group" = filter(<> 'DRIVERS'));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.Get("Account No.") then begin
                    "Vendor Name" := Vend.Name;
                    "Vendor Email" := Vend."E-Mail";
                end;

            end;
        }
        field(4; "Vendor Name"; Text[100])
        {
        }


        field(5; "Awarded"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Awarded By"; Code[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Awarded On"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Award Notification Sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Award Notification Sent By"; Code[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Award Notification Sent On"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Score; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(13; Regret; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Regret Initiated On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Regret Initiated By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Regret Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Vendor Email"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
  
    }

    keys
    {
        key(Key1; "Requisition Document No.", "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure AwardTender()
    var
        RFQVendorsQuotations: Record "RFQ Vendors Quotations";
        RFQVendors: Record "RFQ Vendors";
        ErrorScore: Label 'The score of vendor %1 of %2 is higher than that of the selected vendor to award.!';
        RFQHdr: Record "RFQ Header";
        AwardedSuccessfully: Label 'The tender has been awarded to %1, successfully';
        cnfm: Label 'Sure to award the tender to %1?';
    begin
        if not Confirm(cnfm, false, "Vendor Name") then exit;

        RFQVendorsQuotations.Reset();
        RFQVendorsQuotations.SetRange("Vendor No", "Account No.");
        RFQVendorsQuotations.SetRange("Document No", "Requisition Document No.");
        RFQVendorsQuotations.FindSet();

        repeat
            RFQVendorsQuotations.TestField(Amount);
            RFQVendorsQuotations.TestField("Unit Cost");
        until RFQVendorsQuotations.Next() = 0;

        RFQVendors.Reset();
        RFQVendors.SetRange("Requisition Document No.", "Requisition Document No.");
        if RFQVendors.FindFirst() then
            repeat

                RFQVendors.TestField(Awarded, false);
                RFQVendors.TestField(Score);
                RFQVendors.TestField(Remarks);
                if RFQVendors."Account No." <> "Account No." then
                    if RFQVendors.Score > Score then
                        Error(ErrorScore, RFQVendors."Vendor Name", RFQVendors.Score);

            until RFQVendors.Next() = 0;

        Awarded := true;
        "Awarded By" := UserId;
        "Awarded On" := CurrentDateTime;
        Modify();

        Commit();

        SendAwardEmailToVendor();

        RFQHdr.Reset();
        RFQHdr.SetRange("No.", "Requisition Document No.");
        if RFQHdr.FindFirst() then begin
            RFQHdr.Awarded := true;
            RFQHdr."Awarded On" := CurrentDateTime;
            RFQHdr."Awarded By" := UserId;
            RFQHdr.Modify();
            Message(AwardedSuccessfully, "Vendor Name");
        end;

    end;

    local procedure SendAwardEmailToVendor()
    var
        myInt: Integer;
        Vend: Record Vendor;
        SaccoSetup: Record "Sacco Setup";
        RFQLn: Record "RFQ Line";
        TmpCustomTempBlob: Record CustomTempBlob temporary;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        FileName: Text;
        Base64: Text;
        BodyMsg: Text;
        EmailSub: label 'Tender Award for Tender No %1.';
        SalutationTxt: label 'Dear Sir / Madam,';
        BodyTxt: label 'Congratulations for receiving the tender award %1.!';
        RegardsTxt: label 'Kind Regards,';
        DesclaimerTxt: label 'This is a system generated email. please do not respond to this email';
        ProcessTxt: label 'Successfully Processed.';
    begin


        if not Vend.Get("Account No.") then;

        BodyMsg := (SalutationTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (strsubstno(BodyTxt, Rec."Requisition Document No."));
        BodyMsg += ('<br><br>');
        BodyMsg += (RegardsTxt);
        BodyMsg += ('<br>');
        BodyMsg += (COMPANYNAME);
        BodyMsg += ('<br><br>');
        BodyMsg += ('<HR>');
        BodyMsg += (DesclaimerTxt);

        EmailMsg.Create(Vend."E-Mail", StrSubstNo(EmailSub, "Requisition Document No."), BodyMsg);
        Email.Send(EmailMsg);

    end;

    procedure RejectTender()
    var
        RFQVendorsQuotations: Record "RFQ Vendors Quotations";
        RFQVendors: Record "RFQ Vendors";
        RFQHdr: Record "RFQ Header";
        AwardedSuccessfully: Label 'The tender has been awarded to %1, successfully';
        cnfm: Label 'Sure send regret email to other vendors?';
    begin
        if not Confirm(cnfm, false) then exit;

        RFQVendors.Reset();
        RFQVendors.SetRange("Requisition Document No.", "Requisition Document No.");
        RFQVendors.SetRange(Awarded, true);
        RFQVendors.FindFirst();

        RFQVendors.Reset();
        RFQVendors.SetRange("Requisition Document No.", "Requisition Document No.");
        RFQVendors.SetRange(Awarded, false);
        if RFQVendors.FindFirst() then
            repeat

                SendRegretEmailToVendor(RFQVendors."Account No.");

                RFQVendors.Regret := true;
                RFQVendors."Regret Initiated By" := UserId;
                RFQVendors."Regret Initiated On" := CurrentDateTime;
                RFQVendors."Regret Email Sent" := true;
                RFQVendors.Modify();

            until RFQVendors.Next() = 0;

        Awarded := true;
        "Awarded By" := UserId;
        "Awarded On" := CurrentDateTime;
        Modify();

        Commit();

        SendAwardEmailToVendor();

        RFQHdr.Reset();
        RFQHdr.SetRange("No.", "Requisition Document No.");
        if RFQHdr.FindFirst() then begin
            RFQHdr.Awarded := true;
            RFQHdr."Awarded On" := CurrentDateTime;
            RFQHdr."Awarded By" := UserId;
            RFQHdr.Modify();
            Message(AwardedSuccessfully, "Vendor Name");
        end;

    end;

    local procedure SendRegretEmailToVendor(VendorNo: Code[20])
    var
        myInt: Integer;
        Vend: Record Vendor;
        SaccoSetup: Record "Sacco Setup";
        RFQLn: Record "RFQ Line";
        TmpCustomTempBlob: Record CustomTempBlob temporary;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        FileName: Text;
        Base64: Text;
        BodyMsg: Text;
        EmailSub: label 'Tender Update for Tender No %1.';
        SalutationTxt: label 'Dear Sir / Madam,';
        BodyTxt: label 'Thank you for taking part in this procurement. We have now evaluated all of the final tenders we received. On the basis of this evaluation, wer are writing to advise you that unfortunately on this occasion you have not been successful for tender %1!';
        RegardsTxt: label 'Kind Regards,';
        DesclaimerTxt: label 'This is a system generated email. please do not respond to this email';
        ProcessTxt: label 'Successfully Processed.';
    begin


        if not Vend.Get(VendorNo) then exit;

        BodyMsg := (SalutationTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (strsubstno(BodyTxt, Rec."Requisition Document No."));
        BodyMsg += ('<br><br>');
        BodyMsg += (RegardsTxt);
        BodyMsg += ('<br>');
        BodyMsg += (COMPANYNAME);
        BodyMsg += ('<br><br>');
        BodyMsg += ('<HR>');
        BodyMsg += (DesclaimerTxt);

        EmailMsg.Create(Vend."E-Mail", StrSubstNo(EmailSub, "Requisition Document No."), BodyMsg, true);
        Email.Send(EmailMsg);

    end;

   local procedure GetVendorQuotedAmount(): Decimal
    var
        RFQVendorsQuotations: Record "RFQ Vendors Quotations";
        Total: Decimal;
    begin
        RFQVendorsQuotations.SetRange("Document No", Rec."Requisition Document No.");
        RFQVendorsQuotations.SetRange("Vendor No", Rec."Account No.");
        if RFQVendorsQuotations.FindSet() then
            repeat
                Total += RFQVendorsQuotations.Amount;
            until RFQVendorsQuotations.Next() = 0;
        exit(Total);
    end;


}

