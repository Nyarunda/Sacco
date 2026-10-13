Page 50526 "Agency Devices List"
{
    PageType = List;
    SourceTable = "Sky Agency Devices";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DeviceID; Rec."Device ID")
                {
                    ApplicationArea = Basic;
                }
                field(SerialNumber; Rec."Serial Number")
                {
                    ApplicationArea = Basic;
                }
                field(IMEI; Rec.IMEI)
                {
                    ApplicationArea = Basic;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = Basic;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = Basic;
                }
                field(BoardID; Rec."Board ID")
                {
                    ApplicationArea = Basic;
                }
                field(Version; Rec.Version)
                {
                    ApplicationArea = Basic;
                }
                field(Firmware; Rec.Firmware)
                {
                    ApplicationArea = Basic;
                }
                field(ProcessorID; Rec."Processor ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

