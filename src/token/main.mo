import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor Token {

  Debug.print("Helloo!");

  let owner: Principal = Principal.fromText("ek2la-4rq6v-b5nyz-ddydq-omyco-t4ipo-hrujg-sch2t-xdebp-lhzrd-hqe");
  let totalSupply: Nat = 1000000000;
  let symbol: Text = "DALPR";

  private stable var balanceEntries: [(Principal, Nat)] =[];
  
  private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  if(balances.size() < 1){
    balances.put(owner, totalSupply);
  };

  public query func balanceOf(who: Principal): async Nat {

    let balance: Nat = switch (balances.get(who)){
      case null 0;
      case (?result) result;
    };

    return balance;
  };

  public query func getSymbol(): async Text {
    return symbol;
  };

  public shared(msg) func payOut(): async Text {
    // Debug.print(debug_show(msg.caller));
    if(balances.get(msg.caller) == null){
      let amount = 10000;
      let result = await transfer(msg.caller, amount);
      return result;
    } else {
      return "Already Claimed";
    };
  };

  public shared(msg) func transfer(to: Principal, amount: Nat): async Text {
    let fromBalance: Nat = await balanceOf(msg.caller);

    if(fromBalance > amount) {
      let newFromBalance: Nat = fromBalance - amount;
      balances.put(msg.caller, newFromBalance);

      let toBalance: Nat = await balanceOf(to);
      let newToBalance: Nat = toBalance + amount;
      balances.put(to, newToBalance);

      return "Success";
    } else {
      
      return "Infficient Funds"
    }
  };

  system func preupgrade(){
    balanceEntries := Iter.toArray(balances.entries());
  };

  system func postupgrade(){
    balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);
    if(balances.size() < 1){
      balances.put(owner, totalSupply);
    }
  };
}