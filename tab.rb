# The term “tab” is short for “tabulation.” When used in a bar or restaurant and the server says they are adding something to your “tab,” they are really saying “let me add that to the tabulation for your bill.” - In our case Bar object adding drinks to tab for different guest objects, will assume that the money is exchanged as soon as the drink is purchased. Tab here will be for reporting purposes to report on the amount of drinks each guest purchases.

class Bar
  def initialize()
    # initialize with a default @bar_stock variable that points to hash of alko names strings as keys and hashes containing default stock(in serving units) and unit price(float). As drinks get sold stock will be updated:
    @bar_stock = {
      "vodka" => {stock: 100, price: 4.50},
      "beer" => {stock: 100, price: 3.50},
      "cider" => {stock: 100, price: 3.70}
    }

    # Tab hash will hold guest objects as keys that point to
    # a hash which has name key pointing to guest_objects name variable, and a drinks_bought key pointing to a hash with drink names as keys and purchased units as values:

    # example_tab = {@guest_1 => {name: @guest_1.guest_name,
    #                            drinks_bought: {"vodka" => 1, "beer" => 2}},
    #               @guest_2 => {name: @guest_2.guest_name,
    #                           drinks_bought: {"vodka" => 5, "beer" => 1}},
    #               @guest_3 => {name: @guest_3.guest_name,
    #                            drinks_bought: {"cider" => 5, "beer" => 1}}
    #                         }
    # is it a good practice to use guest_objects as keys? or better to convert to symbols?
    @tab = {}
    # bar_till variable will hold the total value of drinks sold from the bar object
    @bar_till = 0.00
  end

  def report_tab()
    return @tab
  end

  # this will normally be called from the main Room class object(see sell_a_drink_to_guest method in Room class)
  # function will take in  a guest object and a drink name string)
  def sell_a_drink(guest_obj, drink_name_str)
    # availability check
    if @bar_stock.has_key?(drink_name_str) && @bar_stock[drink_name_str][:stock] > 0
      # guest object money check:
      if guest_obj.check_wallet >= @bar_stock[drink_name_str][:price]
        # money out for guest object
        guest_obj.pay(@bar_stock[drink_name_str][:price])
        # money in for bar object
        @bar_till += @bar_stock[drink_name_str][:price]
        # reduce stock in question in @bar_stock object variable:
        @bar_stock[drink_name_str][:stock] -= 1
        # add to tab(this will update tab for a specific guest object):
        add_drink_to_tab(guest_obj, drink_name_str)
      end
        # if guest obj does not have enough money, the
        # message is returned:
        return "Sorry, but you can't afford it."
    end
      # if the guest's chosen drink is not available, message gets returned:
      return "This drink is not available at the moment."
  end

  # add drink to tab function explained: takes in guest object that was inputed to sell_a_drink function as well as his/her chosen drink as a string.
  def add_drink_to_tab(guest_obj, drink_name_str)
    # create a hash value for guest_obj key which is to be
    # added to the @tab hash. this will be utilised to update @tab hash in case, specific guest obj does not yet exist in @tab hash:
    guest_obj_hash_1_buy = {name: guest_obj.guest_name,
            drinks_bought: {drink_name_str => 1}
           }
    # lets start asking if our guest object already exists as a key in @tab hash(perhaps this is not the first drink the guest object bought and he is already on tab?)
    if @tab.has_key?(guest_obj)
      # if he is on tab we need to make sure if drink_name string provided with guest_obj to sell_a_drink function exists as a key in drinks_bought hash before we try to increase the count.
      # if yes, the value corresponding to drink_name str key has already been assigned some int value and we can use +=
      # teh other way to solve this is autovivication (arbitrary dept hashes)

      if @tab[guest_obj][:drinks_bought].has_key?(drink_name_str)
         @tab[guest_obj][:drinks_bought][drink_name_str] += 1
      else
        # if drink_str does not exist yet as a key we use = assingment operator to 1 int, this way next time += will work as ruby no longer assumes a nil value, for key that does not yet exist.
        @tab[guest_obj][:drinks_bought][drink_name_str] = 1
      end

    else
      # in case guest_obj in question is not yet among keys in @tab array, we add it and point it guest_obj_hash_1_buy variable that links to the hash template we created at the start of function.
      @tab[guest_obj] = guest_obj_hash_1_buy
    end
  end

  def check_bar_till
    return @bar_till
  end

  def check_bar_tab(guest_obj)
    return @tab[guest_obj]
  end

  def check_bar_stock(drink_name_str)
    return @bar_stock[drink_name_str][:stock]
  end

end
