import React from "react";
import Header from "./Header";
import Faucet from "./Faucet";
import Balance from "./Balance";
import Transfer from "./Transfer";

function App(props) {
  return (
    <div id="screen">
      <Header />
      <Faucet userPrincipal={props.loggedInPrincipal} />
      <Balance />
      <Transfer />
      <div className="window white">
        <div className="transfer">
          <p> &copy; 2022 - Alper Ergul</p>
        </div>
      </div>
    </div>
  );
}

export default App;
