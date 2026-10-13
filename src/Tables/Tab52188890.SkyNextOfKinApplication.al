table 50592 "Sky Next Of Kin Application"
{
    Caption = 'Sky Next Of Kin Application';
    DataClassification = ToBeClassified;
    
     fields
    {
        field(1;"Application No.";Code[20])
        {
        }
        field(2;"Member No.";Code[20])
        {
        }
        field(3;"Member Name";Text[50])
        {
        }
        field(4;"Application Date";Date)
        {
        }
        field(5;"Application Time";Time)
        {
        }
        field(6;Status;Option)
        {
            OptionMembers = Pending,Approved,Rejected,Cancelled;
        }
        field(7;"Created By";Code[50])
        {
        }
        field(8;"Modified Date";Date)
        {
        }
        field(9;"Modified Time";Time)
        {
        }
        field(10;"Modified By";Code[50])
        {
        }
        field(11;"Approved Date";Date)
        {
        }
        field(12;"Approved Time";Time)
        {
        }
        field(13;"Approved By";Code[50])
        {
        }
        field(14;"Rejected Date";Date)
        {
        }
        field(15;"Rejected Time";Time)
        {
        }
        field(16;"Rejected By";Code[50])
        {
        }
        field(17;"Rejection Reason";Text[250])
        {
        }
        field(18;"Cancelled Date";Date)
        {
        }
        field(19;"Cancelled Time";Time)
        {
        }
        field(20;"Cancelled By";Code[20])
        {
        }
        field(21;"Cancellation Reason";Text[250])
        {
        }
        field(22;"Change Reason";Text[250])
        {
        }
        field(23;"Request ID";Code[150])
        {
        }
        field(24;"No. Series";Code[20])
        {
        }
        field(25;"Application Type";Option)
        {
            Description = 'Unified handles Insert/Update/Delete in one request';
            OptionMembers = " ",Unified;
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
        key(Key3;"Member No.","Application Type")
        {
        }
    }

    fieldgroups
    {
    }
}
