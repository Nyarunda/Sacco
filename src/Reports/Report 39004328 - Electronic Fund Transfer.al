report 50440 "Electronic Fund Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Electronic Fund Transfer.rdlc';

    dataset
    {
        dataitem(EFTHeader; "EFT Transfer")
        {
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(No_EFTHeader; EFTHeader."No.")
            {
            }
            column(Remarks_EFTHeader; EFTHeader."Payment Narration")
            {
            }
            column(Transferred_EFTHeader; EFTHeader.Posted)
            {
            }
            column(DateTransferred_EFTHeader; EFTHeader."Date Posted")
            {
            }
            column(TransferredBy_EFTHeader; EFTHeader."Posted By")
            {
            }
            column(Total_Charges; "Total Charges")
            {
            }
            column(UserId; Cashier)
            {
            }
            column(Approver1; Approver1)
            {
            }
            column(Approver2; Approver2)
            {
            }
            column(Approver3; Approver3)
            {
            }
            dataitem(EFTDetails; "EFT Line")
            {
                DataItemLink = "Header No." = FIELD("No.");
                column(AccountNo_EFTDetails; EFTDetails."Account No.")
                {
                }
                column(StaffNo_EFTDetails; EFTDetails.PayrollAndStaffNo)
                {
                }
                column(AccountName_EFTDetails; EFTDetails.Description)
                {
                }
                column(DestinationAccountType_EFTDetails; 'Bank')
                {
                }
                column(Amount_EFTDetails; EFTDetails.Amount)
                {
                }
                column(DestinationAccountNo_EFTDetails; EFTDetails."Account No.")
                {
                }
                column(DestinationAccountName_EFTDetails; MemberName)
                {
                }
                column(BankNo_EFTDetails; EFTDetails."Bank No")
                {
                }
                column(PayeeBankName_EFTDetails; EFTDetails."Payee Bank Name")
                {
                }
                column(NotAvailable_EFTDetails; '')
                {
                }
                column(PhoneNo_EFTDetails; phone)
                {
                }
                column(TransactionTypeCode_EFTDetails; EFTDetails."Transaction Type")
                {
                }
                column(PurposeofPayment_EFTDetails; EFTDetails.Description)
                {
                }
                column(BeneficiaryAddress_EFTDetails; Address)
                {
                }
                column(ChargeType_EFTDetails; Eftheader."Transaction Type")
                {
                }
                column(TransactionCurrency_EFTDetails; 'KSH')
                {
                }
                column(PaymentType_EFTDetails; Eftdetails."Bank Transaction Code")
                {
                }
                column(BranchCode_EFTDetails; EFTDetails."Bank Code")
                {
                }
                column(Destination_Account_No_; "Destination Account No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    SA: Record "Savings Accounts";
                begin
                    MemberName := '';
                    Address := '';
                    Phone := '';

                    If SA.Get(EFTDetails."Account No.") then begin
                        MemberName := SA.Name;
                        Phone := SA."Phone No.";
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetCurrentKey("Sequence No.");
                ApprovalEntry.SetAscending("Sequence No.", false);
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", GetFilter(EFTHeader."No."));
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then begin
                    //repeat
                    Approver1 := ApprovalEntry."Approver ID";
                    Approver2 := Format(ApprovalEntry."Last Date-Time Modified");
                    /*if ApprovalEntry."Sequence No." = 1 then begin
                        // Approver1:=DELSTR(Approver1,1,16);

                        Approver2 := ApprovalEntry."Approver ID";
                        // Approver2:=DELSTR(Approver2,1,16);
                    end;*/

                    if ApprovalEntry."Sequence No." = 2 then begin
                        Approver3 := ApprovalEntry."Approver ID";
                        // Approver3:=DELSTR(Approver3,1,16);
                    end;
                    //until ApprovalEntry.Next = 0;
                end;
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
        ReportHeader = 'Electronic Fund Transfer Schedule';
        TransferNo = 'Transfer No. :';
        Remarks = 'Remarks :';
        Transferred = 'Transferred :';
        DateTransferred = 'Date Transferred :';
        TransferredBy = 'Transferred By :';
        RecordCount = 'Record Count :';
        Total = 'Total :';
        PreparedBy = 'Prepared by :.......................................................................... Date :....................................... Signature By :..........................................................';
        Ceo = 'CEO :........................................................................................ Date :........................................ Signature :............................................................';
        Treasurer = 'Treasurer :................................................................................. Date :.................................... Signature :............................................................';
        HonSec = 'Hon. Sec :.................................................................................. Date :........................................ Signature :............................................................';
        ViceChairman = 'Vice Chairman :........................................................................... Date :........................................ Signature :............................................................';
        Chairman = 'Chairman :................................................................................. Date :........................................ Signature :............................................................';
        ApprovedBy = 'Approved by :.............................................................................. Date :........................................ Signature :............................................................';
    }

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MemberName: Text[50];
        Phone: Text[30];
        Address: Text[50];
        Approver1: Text;
        Approver2: Text;
        Approver3: Text;
        Date1: Date;
        Date2: Date;
        Date3: Date;
        ApprovalEntry: Record "Approval Entry";

}

