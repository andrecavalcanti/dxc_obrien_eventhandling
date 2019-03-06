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
}