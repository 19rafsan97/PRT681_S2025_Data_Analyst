import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

class SalesDataAnalysis:
    def __init__(self, file_path):
        self.file_path = file_path
        self.data = None

    def load_data(self):
        # Load dataset
        self.data = pd.read_csv(self.file_path)
        print("Data Loaded Successfully!\n")
        print(self.data.head())

    def clean_data(self):
        # Handle missing values and clean dataset
        if self.data is not None:
            self.data.dropna(inplace=True)
            print("Data Cleaned. Shape:", self.data.shape)
        else:
            print("Load data first!")

    def sales_summary(self):
        # sales summary 
        if self.data is not None:
            total_sales = (self.data['Price'] * self.data['Quantity']).sum()
            avg_order_value = (self.data['Price'] * self.data['Quantity']).mean()
            total_orders = len(self.data)

            print("Total Sales: $", round(total_sales, 2))
            print("Average Order Value: $", round(avg_order_value, 2))
            print("Total Orders:", total_orders)
        else:
            print("Load data first!")

    def top_products(self, n=5):
        # top selling products 
        if self.data is not None:
            top = self.data.groupby('Product')['Quantity'].sum().sort_values(ascending=False).head(n)
            print("Top Products by Quantity Sold:\n", top)
        else:
            print("Load data first!")

    def category_sales(self):
        # Visualize sales by category 
        if self.data is not None:
            category_sales = self.data.groupby('Category').apply(lambda x: (x['Price'] * x['Quantity']).sum())
            category_sales.plot(kind='bar', title='Sales by Category', figsize=(8,5), color='skyblue')
            plt.ylabel("Total Sales ($)")
            plt.show()
        else:
            print("Load data first!")

    def monthly_trends(self):
        # Visualize sales trends over months 
        if self.data is not None:
            self.data['Date'] = pd.to_datetime(self.data['Date'])
            monthly_sales = self.data.groupby(self.data['Date'].dt.to_period('M')).apply(lambda x: (x['Price'] * x['Quantity']).sum())
            monthly_sales.plot(kind='line', marker='o', title='Monthly Sales Trend', figsize=(8,5))
            plt.ylabel("Total Sales ($)")
            plt.show()
        else:
            print("Load data first!")


if __name__ == "__main__":
    file_path = "sales_data.csv"  
    analysis = SalesDataAnalysis(file_path)

    analysis.load_data()
    analysis.clean_data()
    analysis.sales_summary()
    analysis.top_products()
    analysis.category_sales()
    analysis.monthly_trends()
