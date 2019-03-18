codeunit 50003 "DXCEventHandling"
{
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvHeaderInsert', '', false, false)]

    local procedure HandleBeforeSalesInvHeaderInsertOnSalesPost(var SalesInvHeader : Record "Sales Invoice Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        SalesInvHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', false, false)]

    local procedure HandleBeforeSalesShptHeaderInsertOnSalesPost(var SalesShptHeader : Record "Sales Shipment Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        SalesShptHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]

    local procedure HandleBeforeSalesCrMemoHeaderInsertOnSalesPost(var SalesCrMemoHeader : Record "Sales Cr.Memo Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        SalesCrMemoHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;
    
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    local procedure HandleBeforeReturnRcptHeaderInsertOnSalesPost(var ReturnRcptHeader : Record "Return Receipt Header"; SalesHeader : Record "Sales Header");
            
    begin

        SalesHeader.CALCFIELDS("DXC Weights and Dims");
        ReturnRcptHeader."DXC Weights and Dims" := SalesHeader."DXC Weights and Dims";         

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure HandleBeforeValidateSellToCustNoOnSalesHeader(var Rec : Record "Sales Header";var xRec : Record "Sales Header";CurrFieldNo : Integer);
    var
        Customer : Record Customer;
    begin

        Customer.GET(Rec."Sell-to Customer No.");
        Rec."DXC Address 3" := Customer."DXC Address 3";
    end;    

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Ship-to Code', false, false)]
    local procedure HandleAfterValidateShipToCodeOnSalesHeader(var Rec : Record "Sales Header";var xRec : Record "Sales Header";CurrFieldNo : Integer);
    var        
        ShipToAddress : Record "Ship-to Address";
    begin
        if (Rec."Sell-to Customer No." <> '') and (Rec."Ship-to Code" <> '') then begin
          ShipToAddress.GET(Rec."Sell-to Customer No.",Rec."Ship-to Code");
          Rec."DXC Ship-to Address 3" := ShipToAddress."DXC Address 3";
        end;
    end;
 
    
}