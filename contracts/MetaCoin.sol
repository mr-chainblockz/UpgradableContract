pragma solidity ^0.4.17;

import "./ConvertLib.sol";
import "./MetaCoinStorage.sol";

contract MetaCoin {
	MetaCoinStorage metaCoinStorage;

	event Transfer(address indexed _from, address indexed _to, uint _value);

	constructor(address metaCoinStorageAddress) {
		metaCoinStorage = MetaCoinStorage(metaCoinStorageAddress);
	}

	function sendCoin(address receiver, uint amount) returns (bool) {
		if (metaCoinStorage.getBalance(msg.sender) < amount) return false;

		metaCoinStorage.setBalance(msg.sender, metaCoinStorage.getBalance(msg.sender) - amount);
		metaCoinStorage.setBalance(receiver, metaCoinStorage.getBalance(receiver) + amount);

		emit Transfer(msg.sender, receiver, amount);

		return true;
	}

	function getBalanceInEth(address _address) returns (uint) {
		return ConvertLib.convert(getBalance(_address), 2);
	}

	function getBalance(address _address) returns (uint) {
		return metaCoinStorage.getBalance(_address);
	}
}
