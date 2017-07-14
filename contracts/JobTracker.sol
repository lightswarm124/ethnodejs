pragma solidity ^0.4.8;

import "./SafeMath.sol";
import "./StandardToken.sol";

contract JobTracker is SafeMath {
    event ChangeOwner(address oldOwner, address newOwner);
    event AcceptWork (address projectManager, address jobWorker, uint amount);

    address public tokenContractAddress;
    StandardToken token;
    address public jobCreator;
    uint256 public lockBlockNumber;
    uint256 public lockPayAmount;

    modifier onlyJobCreator {
        if (msg.sender == jobCreator) _;
    }

    function JobTracker(address _tokenContract) {
        jobCreator = msg.sender;
        token = StandardToken(_tokenContract);
        tokenContractAddress = _tokenContract;
        lockBlockNumber = 0;
        lockPayAmount = 0;
    }

    function shareOf(address _jobWorker) constant returns (uint256) {
        uint256 placeHolder = StandardToken(tokenContractAddress).balanceOf(_jobWorker);
        uint256 t_Supply = StandardToken(tokenContractAddress).totalBalance();
        return div(placeHolder * 1000, t_Supply);
    }

    function acceptWork (address _jobWorker, uint256 _amount) onlyJobCreator {
        token.transfer(_jobWorker, _amount);
        AcceptWork(msg.sender, _jobWorker, _amount);
    }

    function payWorker (address _jobWorker) onlyJobCreator returns (bool) {
        if (this.balance < lockPayAmount || block.number < lockBlockNumber) {
          return false;
        }
        uint256 sendBalance = mul(this.balance, shareOf(_jobWorker));
        sendBalance = div(sendBalance, 1000);
        if (!_jobWorker.send(sendBalance)) throw;
        token.approve(_jobWorker, jobCreator, token.balanceOf(_jobWorker));
        token.transferFrom(_jobWorker, jobCreator, token.balanceOf(_jobWorker));
        return true;
    }

    function changeJobCreator (address _newJobCreator) onlyJobCreator {
        ChangeOwner(jobCreator, _newJobCreator);
        jobCreator = _newJobCreator;
    }

    function lockPayment () onlyJobCreator {
        lockPayAmount = this.balance;
        lockBlockNumber = block.number;
    }

    function () payable {}
}
