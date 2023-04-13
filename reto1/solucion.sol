// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

/*
Investigar que son los Events en Solidity. Luego, debes implementar un evento que se llame 
eventNewPokemon, el cual se disparará cada vez que un nuevo Pokemon es creado.  Lo que emitirá 
el evento será el Pokemon que se creó. 
*/
event eventNewPokemon(address account, Pokemon); // reto1


  struct Pokemon {
    uint id;
    string name;
    Ability[] skills;// reto3
    uint32 kinds; //reto4
    uint32 weaknesses; //reto4
  }

  struct Ability { // reto 3
      string name;
      string description;
  }

  struct num {
      uint256 a;
      uint256 b;
  }


    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

//reto 4
    mapping (uint32 => uint32) private weaknesses; // kind->weaknesses
    mapping(uint32 => string) private kinds;
//fin reto4


//[["name1","desc1"],["name2","desc2"]]
     function createPokemon (string calldata _name, uint _id, Ability[] calldata _skill,uint32[] calldata _kinds) public {
        require(_id>0,"id tiene que ser mayor a 0"); //reto 2
        require(bytes(_name).length >2, "mas de dos caracteres");// reto2

//reto3 inicio
        Pokemon storage aux= pokemons.push();
        aux.id=_id;
        aux.name=_name;
        uint256 _skillSize=_skill.length;
        for(uint256 i=0; i< _skillSize; i++) {
            aux.skills.push(_skill[i]);
        }
//reto3 fin


//reto4 inicio
        uint256 _kindsSize=_kinds.length;
        for(uint256 i=0; i< _kindsSize; i++) {
            aux.kinds|=_kinds[i];
            aux.weaknesses|=weaknesses[_kinds[i]];
        }
//reto4 fin



/* // reto3 me hace tacharlo
        pokemons.push(aux);//Pokemon(_id, _name,));
*/
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, aux);//Pokemon(_id, _name)); // reto 1
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }











//podría hacer los corrimientos del bit en 1 shifteando con esto pero no lo hice para no hacer el codigo tan complejo de comprender
enum PokemonStyle { Non, Normal, Fire, Water, Grass, Flying, Fighting, Poison, Electric, Ground, Rock, Psychic, ICE, Bug, Ghost, Steel, Dragon, Dark, Fairy }


  constructor()
  {
    // by doing a simple or we can have all the kinds possible
    kinds[0x00000] = "";        //0
    kinds[0x00001] = "Normal";  //1
    kinds[0x00002] = "Fire";    //2
    kinds[0x00004] = "Water";   //4
    kinds[0x00008] = "Grass";   //8
    kinds[0x00010] = "Flying";  //16
    kinds[0x00020] = "Fighting";//32
    kinds[0x00040] = "Poison";  //64
    kinds[0x00080] = "Electric";//128
    kinds[0x00100] = "Ground";  //256
    kinds[0x00200] = "Rock";    //512
    kinds[0x00400] = "Psychic"; //1024
    kinds[0x00800] = "ICE";     //2048
    kinds[0x01000] = "Bug";     //4096
    kinds[0x02000] = "Ghost";   //8192
    kinds[0x04000] = "Steel";   //16384
    kinds[0x08000] = "Dragon";  //32768
    kinds[0x10000] = "Dark";    //65536
    kinds[0x20000] = "Fairy";   //131072

    // this is the table of weaknesses for a specific kind of pokemon but we can get all the pokemon weaknesess
    // when the pokemon is a mixture just by doing an or with mappings.
    weaknesses[0x00001] = 0x00020;
    weaknesses[0x00002] = 0x00004|0x00100|0x00200;
    weaknesses[0x00004] = 0x00080|0x00008;
    weaknesses[0x00008] = 0x01000|0x00010|0x00040|0x00800|0x00002;
    weaknesses[0x00080] = 0x00100;
    weaknesses[0x00800] = 0x04000|0x00200|0x00020|0x00002;
    weaknesses[0x00020] = 0x20000|0x00010|0x00400;
    weaknesses[0x00040] = 0x00400|0x00100;
    weaknesses[0x00100] = 0x00004|0x00008|0x00800;
    weaknesses[0x00010] = 0x00200|0x00080|0x00800;
    weaknesses[0x00400] = 0x01000|0x02000|0x10000;
    weaknesses[0x01000] = 0x00010|0x00200|0x00002;
    weaknesses[0x00200] = 0x04000|0x00004|0x00020|0x00008|0x00100;
    weaknesses[0x02000] = 0x10000|0x02000;
    weaknesses[0x08000] = 0x08000|0x20000|0x00800;
    weaknesses[0x10000] = 0x20000|0x00020|0x01000;
    weaknesses[0x04000] = 0x00002|0x00020|0x00100;
    weaknesses[0x20000] = 0x00040|0x04000;
  }




}
