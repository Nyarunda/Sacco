
Table 50267 "Sky SMS"
{

    fields
    {
        field(1; originator_id; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; msg_id; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(3; msg_product_id; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(4; msg_provider_code; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; msg_charge; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; msg_status_code; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; msg_status_description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; msg_status_date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; sender; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; receiver; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; msg; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; msg_type; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(13; msg_source_reference; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; msg_destination_reference; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; msg_xml_data; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(16; msg_category; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; msg_priority; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; msg_send_count; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; schedule_msg; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; date_scheduled; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(21; msg_send_integrity_hash; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; msg_response_date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(23; msg_response_xml_data; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; msg_response_integrity_hash; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; transaction_date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(26; date_created; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "SMS Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Account To Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(101; transaction_id; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(103; server_id; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(107; msg_charge_applied; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(114; msg_format; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(116; msg_command; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(117; msg_sensitivity; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(127; msg_response_description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(301; msg_result_description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(302; msg_result_xml_data; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(303; msg_result_date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(304; msg_result_integrity_hash; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(305; msg_result_submit_count; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(306; msg_result_submit_status; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(307; msg_result_submit_description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(308; msg_result_submit_date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(309; msg_general_flag; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(310; sender_type; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(311; receiver_type; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(312; "Charge Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(313; Finalized; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(314; "Split Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(315; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Account No." = field("Account To Charge")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(316; msg_request_application; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(317; msg_request_correlation_id; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(318; msg_source_application; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(319; msg_response; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(320; msg_response_code; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(321; msg_result; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(322; msg_result_code; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(323; msg_mode; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(325; "Entered By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; originator_id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

