report 50101 "Store Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Store Requisition.rdlc';

    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }

            column(USERID; UserId)
            {
            }
            column(Store_Requistion_Header__Required_Date_; "Required Date")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_4_Code_; "Shortcut Dimension 4 Code")
            {
            }
            column(Store_Requistion_Header_Dim4; Dim4)
            {
            }
            column(Store_Requistion_Header__Request_date_; "Request date")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_3_Code_; "Shortcut Dimension 3 Code")
            {
            }
            column(Store_Requistion_Header_Dim3; Dim3)
            {
            }
            column(Store_Requistion_Header__Request_Description_; "Request Description")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Store_Requistion_Header__Budget_Center_Name_; "Budget Center Name")
            {
            }
            column(Store_Requistion_Header__No__; "No.")
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Store_Requistion_Header__Function_Name_; "Function Name")
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755048; UserId)
            {
            }
            column(Store_RequistionCaption; Store_RequistionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Store_Requistion_Lines_DescriptionCaption; "Store Requisition Lines".FieldCaption(Description))
            {
            }
            column(Store_Requistion_Lines_QuantityCaption; "Store Requisition Lines".FieldCaption(Quantity))
            {
            }
            column(UoMCaption; UoMCaptionLbl)
            {
            }
            column(Store_Requistion_Lines__Line_Amount_Caption; "Store Requisition Lines".FieldCaption("Line Amount"))
            {
            }
            column(Store_Requistion_Lines__Unit_Cost_Caption; "Store Requisition Lines".FieldCaption("Unit Cost"))
            {
            }
            column(Store_Requistion_Header__Required_Date_Caption; FieldCaption("Required Date"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_4_Code_Caption; FieldCaption("Shortcut Dimension 4 Code"))
            {
            }
            column(Store_Requistion_Lines__No__Caption; "Store Requisition Lines".FieldCaption("No."))
            {
            }
            column(Store_Requistion_Header__Request_date_Caption; FieldCaption("Request date"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_3_Code_Caption; FieldCaption("Shortcut Dimension 3 Code"))
            {
            }
            column(Store_Requistion_Header__Request_Description_Caption; FieldCaption("Request Description"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_Caption; FieldCaption("Shortcut Dimension 2 Code"))
            {
            }
            column(Store_Requistion_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Name_Caption_Control1102755052; Name_Caption_Control1102755052Lbl)
            {
            }
            column(Date_Caption_Control1102755053; Date_Caption_Control1102755053Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(AuthorisationsCaption; AuthorisationsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption_Control1102755000; Signature_Caption_Control1102755000Lbl)
            {
            }
            column(DocHeader; DocHeader)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            dataitem("Store Requisition Lines"; "Store Requisition Lines")
            {
                DataItemLink = "Requistion No" = FIELD("No.");
                DataItemTableView = SORTING("Requistion No", "Line No.") ORDER(Ascending);
                column(Store_Requistion_Lines__No__; "No.")
                {
                }
                column(Store_Requistion_Lines_Description; Description)
                {
                }
                column(Store_Requistion_Lines_Quantity; Quantity)
                {
                }
                column(Store_Requistion_Lines__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Store_Requistion_Lines__Line_Amount_; "Line Amount")
                {
                }
                column(Store_Requistion_Lines__Unit_Cost_; "Unit Cost")
                {
                }
                column(Store_Requistion_Lines_Requistion_No; "Requistion No")
                {
                }
                column(Store_Requistion_Lines_Line_No; "Store Requisition Lines"."Line No.")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(UserSetupSignature; CompanyInfo.Picture)
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; CompanyInfo.Picture)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //  CalcFields("User Setup".Signature);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if UserSetup.Get("Sender ID") then;
                    // UserSetup.CalcFields(UserSetup.Signature);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Document Type" = "Document Type"::Grant then
                    DocHeader := 'Staff Grant Requisition'
                else
                    DocHeader := 'Store Requisition';

                if Status = Status::Posted then begin
                    if "Document Type" = "Document Type"::Grant then
                        DocHeader := 'Staff Grant Issue'
                    else
                        DocHeader := 'Store Issue'
                end
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
        PreparedBy = 'Prepared by :........................................Date :............................. Signature :..............................................';
        ApprovedBy = 'Approved by :....................................... Date :............................. Signature :...............................................';

    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        Store_RequistionCaptionLbl: Label 'Store Requistion';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        UoMCaptionLbl: Label 'UoM';
        Date_CaptionLbl: Label 'Date:';
        Name_CaptionLbl: Label 'Name:';
        RecipientCaptionLbl: Label 'Recipient';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Name_Caption_Control1102755052Lbl: Label 'Name:';
        Date_Caption_Control1102755053Lbl: Label 'Date:';
        Signature_CaptionLbl: Label 'Signature:';
        AuthorisationsCaptionLbl: Label 'Authorisations';
        EmptyStringCaptionLbl: Label '================================================================================================================================================================================================';
        Signature_Caption_Control1102755000Lbl: Label 'Signature:';
        DocHeader: Text;
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
}