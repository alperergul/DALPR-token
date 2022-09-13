import React, { useState } from "react";
import { AuthClient } from "../../../../node_modules/@dfinity/auth-client/lib/cjs/index";
import { canisterId, createActor } from "../../../declarations/token";

function Faucet(props) {
  const [isDisabled, setIsDisabler] = useState(false);
  const [buttonText, setButtonText] = useState("Gimme gimme");

  async function handleClick(event) {
    setIsDisabler(true);

    const authClient = await AuthClient.create();
    const identity = await authClient.getIdentity();
    console.log(identity);

    const authenticatedCanister = createActor(canisterId, {
      agentOptions: { identity },
    });

    const result = await authenticatedCanister.payOut();
    setButtonText(result);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>
        Get your free DALPR tokens here! Claim 10,000 DALPR coins to{" "}
        {props.userPrincipal}.
      </label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
