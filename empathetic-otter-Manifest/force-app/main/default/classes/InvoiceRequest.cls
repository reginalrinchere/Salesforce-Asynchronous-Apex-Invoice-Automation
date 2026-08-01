public class InvoiceRequest {
                    public String customerName;
                    public Decimal amount;
                    public List<Item> items;
public class Item {
                    public String productName;
                    public Decimal price;
}
}