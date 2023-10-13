import pandas as pd
import scipy.stats as stats

# calculated -> product 
# c_product_attribute

def getAnalysis(i):
    # Set the value of i to 1

    # Read Excel files using pandas
    i_student = pd.read_excel(f"./decision/i_Decision Summary_adv_t{i}.xlsx")
    c_data = pd.read_excel(f"./product/c_Product_Attribute_Perceptions{i-1}.xlsx")
    i_shift = pd.read_excel(f"./shift/i_shift_t{i}.xlsx")

    # Calculate price
    price = 0.0834 * i_student['Price'] - 33.383
    c_data1 = c_data.copy()
    c_data1['Price'] = round(price, 2)

    # Define prcpt_change function
    def prcpt_change(shift, base=0):
        change = 8 * stats.norm.cdf(shift, loc=base, scale=3) - 4
        return change

    # Update c_data1 with perceptual map data``
    c_data1['Wt.'] = c_data['Wt.'] + prcpt_change(i_shift['Weight'])
    c_data1['Complex.'] = c_data['Complex.'] + prcpt_change(i_shift['Complexity'])
    c_data1['Freq.'] = c_data['Freq.'] + prcpt_change(i_shift['Frequency'])
    c_data1['Power'] = c_data['Power'] + prcpt_change(i_shift['Power'])
    c_data1['Speed'] = c_data['Speed'] + prcpt_change(i_shift['Speed'])

    # Write c_data1 to Excel file
    with pd.ExcelWriter("./calculated_tables_t.xlsx") as writer:
        c_data1.to_excel(writer, sheet_name="c_Product Attribute Perceptions", index=False)
