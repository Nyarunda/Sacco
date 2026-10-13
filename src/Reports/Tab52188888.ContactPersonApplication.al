table 50590 "Contact Person Application"
{
    Caption = 'Contact Person Application';
    DataClassification = ToBeClassified;
    
     fields
    {
        field(1;"Application No.";Code[20])
        {
        }
        field(2;"Member No.";Code[20])
        {
        }
        field(3;"Member Name";Text[100])
        {
        }
        field(4;"Contact Person Name";Text[100])
        {
        }
        field(5;"Contact Person Phone";Text[15])
        {
        }
        field(6;"Contact Person Relation";Code[20])
        {
        }
        field(7;"Application Date";Date)
        {
        }
        field(8;"Application Time";Time)
        {
        }
        field(9;"Created By";Code[50])
        {
        }
        field(10;"Request ID";Code[150])
        {
        }
        field(11;"Change Reason";Text[150])
        {
        }
        field(12;"Approved By";Code[50])
        {
        }
        field(13;"Approved Date";Date)
        {
        }
        field(14;"Approved Time";Time)
        {
        }
        field(15;"Approval Remarks";Text[150])
        {
        }
        field(16;"Rejected By";Code[50])
        {
        }
        field(17;"Rejected Date";Date)
        {
        }
        field(18;"Rejected Time";Time)
        {
        }
        field(19;"Rejection Reason";Text[250])
        {
        }
        field(20;"Cancelled By";Code[50])
        {
        }
        field(21;"Cancelled Date";Date)
        {
        }
        field(22;"Cancelled Time";Time)
        {
        }
        field(23;"Cancellation Reason";Text[150])
        {
        }
        field(24;"Old Contact Person Name";Text[150])
        {
        }
        field(25;"Old Contact Person Phone";Text[20])
        {
        }
        field(26;"Old Contact Person Relation";Code[20])
        {
        }
        field(27;"No. Series";Code[10])
        {
        }
        field(28;Status;Option)
        {
            OptionMembers = Pending,Approved,Rejected,Cancelled;
        }
    }

    keys
    {
        key(Key1;"Application No.")
        {
        }
        key(Key2;"Member No.",Status)
        {
        }
        key(Key3;Status,"Application Date")
        {
        }
    }

    fieldgroups
    {
    }
}
