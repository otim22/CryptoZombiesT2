pragma solidity >=0.4.0 <0.6.0;


/// @title CryptoZombies Lesson 1
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT2/Lesson1
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/architecure.md

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint minNameLength = 1;
    uint maxNameLength = 15;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

// req ZF_6 Make Zombie in struct and emit id, name and dna
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

// req ZF_1 Push the Zombie attributes in the zombies struct
// req ZF_2 Emit the Zombie id, name and dna
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    } 

// req ZF_3 Generate a pseudo random number from a string which is returned as the dna
// req ZF_4 Throw an error if string length 1 char or less
// req ZF_5 Create id which represents the index of the Zombie in the struct on blockchain
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint len = bytes(_str).length;
        require((len > minNameLength && len < maxNameLength), "Name bad length");  
                    // New code added for tests
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

}

