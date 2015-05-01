class Array
  def my_uniq
    uniques = []
    self.each { |el| uniques << el unless uniques.include?(el) }
    uniques
  end

  def two_sum
    pairs = []
    self.each_index do |el_idx|
      i = el_idx + 1
      until i == self.length
        pairs << [el_idx, i] if self[el_idx] + self[i] == 0
        i += 1
      end
    end
    pairs
  end

  def my_transpose
    transposition = Array.new(self[0].size) { [] }
    self.each_with_index do |row, row_indx|
      self[row_indx].each_with_index do |el, col_indx|
        transposition[col_indx][row_indx] = el
      end
    end
    transposition
  end

  def stock_picker
    best_profit = 0
    best_stock_days = []

    self.each_with_index do |price, buy_date|
      future_date = buy_date + 1
      while future_date < self.length
        current_profit = self[future_date] - price
        if current_profit > best_profit
          best_profit = current_profit
          best_stock_days = [buy_date, future_date]
        end
        future_date += 1
      end
    end

    best_stock_days
  end
end
