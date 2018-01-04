pragma solidity ^0.4.18;

contract PayMePlz {
  address owner;
  uint threshold;
  mapping (address => bool) peopleWhoPaid;

  // constructor
  function PayMePlz() {
    owner = msg.sender;
    threshold = 1000;   // how much wei each user needs to pay
  }

  // people paying in
  function pay() payable {
    if (msg.value > threshold) {
      peopleWhoPaid[msg.sender] = true; // mark down who paid
      owner.transfer(msg.value);        // send owner the money
    }
  }

  // checking if user paid (to enable features)
  function didUserPay(uint threshold) public view returns (bool) {
    bool answer = false;
    if (peopleWhoPaid[msg.sender] == true) {
      answer = true;
    }
    return answer;
  }
}