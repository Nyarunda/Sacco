
Page 50193 "Loan Security"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loan Security";
    PromotedActionCategories = 'New,Process,Report,Suggest Micro Guarantors,Defaulter Notices';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GuarantorType; Rec."Guarantor Type")
                {
                    ApplicationArea = Basic;
                }

                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                    begin
                        Rec."Account No." := '';
                        if Rec."Guarantor Type" = Rec."Guarantor Type"::Collateral then begin
                            Members.Reset();
                            Members.setfilter(type, '<>%1', Members.Type::" ");
                            if Page.RunModal(Page::"Member List", Members) = Action::LookupOK then
                                Rec."Account No." := Members."No.";
                        end
                        else
                            if Rec."Guarantor Type" = Rec."Guarantor Type"::Guarantor then begin
                                Accounts.Reset();
                                Accounts.setfilter("Product Category", '%1|%2|%3', Accounts."Product Category"::"Deposit Contribution", Accounts."Product Category"::"Micro Member Deposit", Accounts."Product Category"::"Micro Group Deposit");
                                //RefreshOldMemberNumbers(Accounts);
                                if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                    Rec."Account No." := Accounts."No.";
                            end
                            else
                                if Rec."Guarantor Type" = Rec."Guarantor Type"::Lien then begin
                                    Accounts.Reset();
                                    Accounts.setfilter("Product Category", '%1|%2|%3|%4', Accounts."Product Category"::"Fixed Deposit", Accounts."Product Category"::"Holiday Savings", Accounts."Product Category"::"Ordinary Savings", Accounts."Product Category"::"Junior Savings");
                                    //RefreshOldMemberNumbers(Accounts);
                                    if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                        Rec."Account No." := Accounts."No.";
                                end;

                        Rec.Validate("Account No.");
                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = basic;
                }
                field(CollateralRegNo; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field(SecurityDetails; Rec."Security Details")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Current Guarantor Deposits"; Rec."Current Guarantor Deposits")
                {
                    Caption = 'Deposits';
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AvailableGuarantorship; Rec."Available Guarantorship")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AmountGuaranteed; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCommitted; Rec."Total Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentCommitted; Rec."Current Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                }
                field("Substituted Member"; Rec."Substituted Member")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Cap Guarantorship?"; Rec."Cap Guarantorship")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    ApplicationArea = Basic;
                }
                field("Member Guaranteed"; Rec."Member Guaranteed")
                {
                    ApplicationArea = Basic;
                }

            }
            group(Control20)
            {
                caption = 'Guarantor Details';
                fixed(Control19)
                {
                    group(DepositsCollateralLimit)
                    {
                        Caption = 'Deposits/Collateral Limit';
                        field("Guarantor Details"; Rec."Guarantor Deposits")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group(GuaranteedinApplication)
                    {
                        Caption = 'Guaranteed in Application';
                        field(ApplicationAmountGuaranteed; Rec."Application Amount Guaranteed")
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                    group(GuarantorDetails)
                    {
                        Caption = 'Total Guarantor Commitment';
                        field(TotalGuarantorCommitment; Rec."Total Guarantor Commitment")
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                }
            }
            group(Control12)
            {
                caption = 'Guarantor Details Figures';
                fixed(Control11)
                {
                    group(RequestedAmount)
                    {
                        Caption = 'Requested Amount';
                        field("Guarantorship Summary"; RequestedAmount)
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                    group(TotalGuaranteed)
                    {
                        Caption = 'Total Guaranteed';
                        field(Control7; TotalGuaranteed)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Guarantorship Balance")
                    {
                        Caption = 'Guarantorship Balance';
                        field(GuarantorshipBalance; GuarantorshipBalance)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                        }
                    }
                }
            }
        }

        area(factboxes)
        {
            part(Control3; "Picture & Signature")
            {
                SubPageLink = "Member No." = field("Member No");
            }
            part(Control66; "Info Base")
            {
                SubPageLink = "Member No." = field("Member No");
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Defaulter Notice-1 SMS")
            {
                ApplicationArea = Basic;
                Image = LimitedCredit;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SendDefaulterNoticeSms(1);
                end;
            }
            action("Defaulter Notice-2 SMS")
            {
                ApplicationArea = Basic;
                Image = LimitedCredit;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SendDefaulterNoticeSms(2);
                end;
            }
            action("Defaulter Notice-3 SMS")
            {
                ApplicationArea = Basic;
                Image = LimitedCredit;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SendDefaulterNoticeSms(3);
                end;
            }
            action("Statutory Notice-1")
            {
                ApplicationArea = Basic;
                Caption = 'Statutory Notice-1';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoanSecurity: Record "Loan Security";
                begin
                    Rec.TestField("Loan No.");
                    Rec.TestField("Collateral Reg. No.");
                    if Rec."Guarantor Type" <> Rec."Guarantor Type"::Collateral then
                        Error('Statutory Notice-1 can only be generated for collateral security lines.');

                    LoanSecurity := Rec;
                    LoanSecurity.SetRecFilter();
                    Report.Run(Report::"Statutory Notice-1", true, false, LoanSecurity);
                end;
            }
            action("Statutory Notice-2")
            {
                ApplicationArea = Basic;
                Caption = 'Statutory Notice-2';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoanSecurity: Record "Loan Security";
                begin
                    Rec.TestField("Loan No.");
                    Rec.TestField("Collateral Reg. No.");
                    if Rec."Guarantor Type" <> Rec."Guarantor Type"::Collateral then
                        Error('Statutory Notice-2 can only be generated for collateral security lines.');

                    LoanSecurity := Rec;
                    LoanSecurity.SetRecFilter();
                    Report.Run(Report::"Statutory Notice-2", true, false, LoanSecurity);
                end;
            }
            action("Defaulter Notice Guarantors")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;
                visible = false;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    Loan: Record Loans;
                    Members: Record Members;
                    Accounts: Record "Savings Accounts";
                    Lsecurity: Record "Loan Security";
                begin
                    Lsecurity.Reset;
                    Lsecurity.SetRange("Loan No.", Rec."Loan No.");
                    Lsecurity.SetRange("Account No.", Rec."Account No.");
                    if Lsecurity.FindFirst() then begin
                        Report.Run(Report::"Defaulter Notice - Guarantor", true, false, Lsecurity)
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetPageEditability();
        CalculateGuarantorshipSummary;
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageEditability();

        CalculateGuarantorshipSummary;
        SetCollateralType();
    end;

    trigger OnClosePage()
    begin

        if Loan.Get(Rec."Loan No.") then begin
            MicroDef := '';

            if ProdFac.Get(Loan."Loan Product Type") then begin
                if not Loan."Self Guarantee" then
                    if ProdFac."Minimum Guarantors" > 0 then begin
                        LoanGua.Reset;
                        LoanGua.SetRange(LoanGua."Loan No.", Loan."Loan No.");
                        LoanGua.SetFilter("Guarantor Type", '%1', LoanGua."guarantor type"::Guarantor);
                        if LoanGua.Find('-') then begin
                            repeat
                                Loan.Reset;
                                Loan.SetFilter("Outstanding Principal", '>0');
                                Loan.SetRange("Member No.", LoanGua."Member No");
                                Loan.SetFilter("Loans Category-SACCO", '<>%1&<>%2', Loan."Loans Category-SACCO"::Perfoming, Loan."Loans Category-SACCO"::Watch);
                                if Loan.FindFirst then begin
                                    repeat
                                        MicroDef += '\ - ' + Loan."Member No." + ' - ' + Loan."Member Name" + '-' + Loan."Loan Product Type" + '-' + Format(Loan."Loans Category-SACCO");
                                    until Loan.Next = 0;
                                end;
                            until LoanGua.Next = 0;
                        end;
                    end;
            end;

            if MicroDef <> '' then begin
                //Message('The following Guarantor(s) are Defaulters: \' + MicroDef);
            end;
        end;

        //Rec.CollateralHistory();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnOpenPage()
    begin
        SetPageEditability();

        CalculateGuarantorshipSummary;
    end;

    var
        SourceType: enum "SMS Source Enum";//Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        CompInfo: Record "Company Information";
        Msg: Text;
        TotalGuaranteed: Decimal;
        RequestedAmount: Decimal;
        ApprovedAmount: Decimal;
        GuarantorshipBalance: Decimal;
        GCount: Integer;
        GAmount: Decimal;
        MicroDef: Text;
        MemberActivities: Codeunit "Member Activities";
        Member_: Record Members;
        Members: Record Members;
        Loan: Record Loans;
        LoanApp: Record "Loan Security";
        ProdFac: Record "Product Setup";
        LoanGua: Record "Loan Security";
        picture: record "Member Images";
        Signature: Record "Member Images";


    procedure CalculateGuarantorshipSummary()
    begin

        RequestedAmount := 0;
        ApprovedAmount := 0;
        TotalGuaranteed := 0;
        GuarantorshipBalance := 0;

        if Loan.Get(Rec."Loan No.") then begin
            RequestedAmount := Loan."Requested Amount";
            ApprovedAmount := Loan."Approved Amount";
        end;

        LoanGua.Reset;
        LoanGua.SetRange("Loan No.", Rec."Loan No.");
        LoanGua.SetRange(Substituted, false);
        if LoanGua.Find('-') then begin
            repeat
                TotalGuaranteed += LoanGua."Amount Guaranteed";
            until LoanGua.Next = 0;
        end;

        GuarantorshipBalance := RequestedAmount - TotalGuaranteed;
    end;

    local procedure SetCollateralType()
    var
        SecReg: Record "Loan Collateral Register";
    begin
        if Rec."Collateral Type" = Rec."Collateral Type"::" " then begin
            if SecReg.Get(Rec."Collateral Reg. No.") then begin
                Rec."Collateral Type" := SecReg."Collateral Type";
                Rec.Modify();
            end;
        end;
    end;

    local procedure SendDefaulterNoticeSms(NoticeNo: Integer)
    var
        GuarantorMsg: Text;
        MemberMsg: Text;
        PreviewMsg: Text;
        GuarantorCount: Integer;
    begin
        if not Loan.Get(Rec."Loan No.") then
            Error('Loan %1 was not found.', Rec."Loan No.");

        GuarantorMsg := GetDefaulterGuarantorSms(NoticeNo, Loan);
        MemberMsg := GetDefaulterMemberSms(NoticeNo, Loan);
        GuarantorCount := CountDefaulterSmsGuarantors(Loan."Loan No.");

        if GuarantorCount = 0 then
            Error('No active guarantors with guaranteed amount were found for loan %1.', Loan."Loan No.");

        PreviewMsg :=
            StrSubstNo(
                'Defaulter Notice-%1 SMS Preview\Loan No.: %2\Member: %3\Guarantor recipients: %4\\Guarantor SMS:\%5\\Member SMS:\%6\\Do you wish to send these SMS notifications?',
                NoticeNo,
                Loan."Loan No.",
                Loan."Member Name",
                GuarantorCount,
                GuarantorMsg,
                MemberMsg);

        if not Confirm(PreviewMsg, false) then
            exit;

        LoanGua.Reset();
        LoanGua.SetRange("Loan No.", Loan."Loan No.");
        LoanGua.SetRange(Substituted, false);
        LoanGua.SetFilter("Amount Guaranteed", '>0');
        LoanGua.SetFilter("Name", '<>%1', '');
        if LoanGua.FindSet() then
            repeat
                if Members.Get(LoanGua."Member No") then
                    MemberActivities.SendSms(SourceType::"Loan Guarantors", Members."Mobile Phone No.", GuarantorMsg, Loan."Loan No.", Loan."Disbursement Account No", true, false);
            until LoanGua.Next() = 0;

        if Member_.Get(Loan."Member No.") then
            MemberActivities.SendSms(SourceType::"Loan Guarantors", Member_."Mobile Phone No.", MemberMsg, Loan."Loan No.", Loan."Disbursement Account No", true, false);

        Message('SMS Sent');
    end;

    local procedure CountDefaulterSmsGuarantors(LoanNo: Code[20]): Integer
    var
        GuarantorCount: Integer;
    begin
        LoanGua.Reset();
        LoanGua.SetRange("Loan No.", LoanNo);
        LoanGua.SetRange(Substituted, false);
        LoanGua.SetFilter("Amount Guaranteed", '>0');
        LoanGua.SetFilter("Name", '<>%1', '');
        if LoanGua.FindSet() then
            repeat
                if Members.Get(LoanGua."Member No") then
                    GuarantorCount += 1;
            until LoanGua.Next() = 0;

        exit(GuarantorCount);
    end;

    local procedure GetDefaulterGuarantorSms(NoticeNo: Integer; DefaulterLoan: Record Loans): Text
    begin
        case NoticeNo of
            1:
                exit('This is to notify you that the ' + DefaulterLoan."Loan Product Type Name" + ' that you guaranteed ' + DefaulterLoan."Member Name" + ' has been defaulted. Kindly notify the defaulter to pay his/her loans');
            2:
                exit('This is to notify you that we have not received any payment from ' + DefaulterLoan."Member Name" + ' since the first notice was sent');
            3:
                exit('This is to notify you that the defaulter ' + DefaulterLoan."Member Name" + ' has not paid and the loan has been apportioned to guarantors');
        end;
    end;

    local procedure GetDefaulterMemberSms(NoticeNo: Integer; DefaulterLoan: Record Loans): Text
    begin
        case NoticeNo of
            3:
                exit('This is to notify you that your ' + DefaulterLoan."Loan Product Type Name" + ' loan is in default. Kindly note that it is due for recovery from your guarantors');
            else
                exit('This is to notify you that your ' + DefaulterLoan."Loan Product Type Name" + ' loan is in default. Kindly note that we have notified your guarantors');
        end;
    end;

    local procedure SetPageEditability()
    var
        LoanAppraisal: Record "Member Salary Appraisal";
        AppraisalNo: Code[20];
    begin
        AppraisalNo := Rec."Loan No.";
        if AppraisalNo = '' then
            AppraisalNo := Rec.GetRangeMin("Loan No.");

        if (AppraisalNo <> '') and LoanAppraisal.Get(AppraisalNo) then
            CurrPage.Editable := LoanAppraisal.Status <> LoanAppraisal.Status::Approved
        else
            CurrPage.Editable := true;

        if Loan.Get(Rec."Loan No.") then begin
            if (Loan.Posted) or (Loan.Status = Loan.Status::Approved) then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;
    end;

    local procedure RefreshOldMemberNumbers(var Accounts: Record "Savings Accounts")
    var
        AccountsToUpdate: Record "Savings Accounts";
    begin
        AccountsToUpdate.Copy(Accounts);
        AccountsToUpdate.SetRange("Old Member Number", '');
        if AccountsToUpdate.FindSet(true) then
            repeat
                AccountsToUpdate.CalcFields("Old Member No.");
                if AccountsToUpdate."Old Member No." <> '' then begin
                    AccountsToUpdate."Old Member Number" := AccountsToUpdate."Old Member No.";
                    AccountsToUpdate.Modify();
                end;
            until AccountsToUpdate.Next() = 0;
    end;

}


