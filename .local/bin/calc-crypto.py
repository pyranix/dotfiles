def calculate_profit(initial_price, final_price, leverage, initial_capital_rp, exchange_rate):
    # Step 1: Convert capital to USD
    initial_capital_usd = initial_capital_rp / exchange_rate

    # Step 2: Calculate total position with leverage
    total_position = initial_capital_usd * leverage

    # Step 3: Calculate how many coins you can buy
    coins_purchased = total_position / initial_price

    # Step 4: Calculate the value of your position when the price increases
    final_position_value = coins_purchased * final_price

    # Step 5: Calculate the gross profit
    gross_profit_usd = final_position_value - total_position

    # Step 6: Convert the profit to Rupiah
    gross_profit_rp = gross_profit_usd * exchange_rate

    return gross_profit_rp

# Input values from the user
initial_price = float(input("Masukkan harga beli koin (USD): "))
final_price = float(input("Masukkan harga jual koin (USD): "))
leverage = float(input("Masukkan leverage yang digunakan: "))
initial_capital_rp = float(input("Masukkan modal awal dalam Rupiah: "))
exchange_rate = float(input("Masukkan kurs Rupiah ke USD: "))

# Calculate profit
profit = calculate_profit(initial_price, final_price, leverage, initial_capital_rp, exchange_rate)

# Print the result
print(f"Keuntungan yang diperoleh adalah Rp {profit:.2f}")
