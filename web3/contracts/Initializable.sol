// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// IMPORTING CONTRACT
// import "./Address.sol"; importuje kontrakt zewnętrzny, który zapewnia dodatkowe funkcjonalności, takie jak sprawdzanie, czy dany adres jest kontraktem.
import "./Address.sol";

// abstract contract Initializable { ... } tworzy abstrakcyjny kontrakt, który nie może być wdrożony bezpośrednio, ale służy jako bazowy szablon dla innych kontraktów.
abstract contract Initializable {
    // _initialized: Licznik inicjalizacji, śledzący, czy kontrakt został zainicjalizowany.
    uint8 private _initialized;

    // _initializing: Boolowska flaga, wskazująca, czy kontrakt jest aktualnie w trakcie inicjalizacji.
    bool private _initializing;

    // event Initialized(uint8 version); definiuje zdarzenie, które jest emitowane po inicjalizacji lub re-inicjalizacji kontraktu.
    event Initialized(uint8 version);

    // initializer: Zapewnia, że dany fragment kodu (funkcja) może być wykonany tylko raz, podczas pierwszej inicjalizacji kontraktu.
    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            (isTopLevelCall && _initialized < 1) ||
                (!Address.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }
    // reinitializer(uint8 version): Umożliwia re-inicjalizację kontraktu do nowej wersji.
    modifier reintializer(uint8 version) {
        require(
            !_initializing && _initialized < version,
            "Initializable: contract is already initialized"
        );
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized(version);
    }
    // onlyInitializing: Ogranicza wykonanie kodu tylko do momentu, gdy kontrakt jest w stanie inicjalizacji.
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    //     _disableInitializers(): Zabezpiecza kontrakt przed dalszymi inicjalizacjami, ustawiając licznik inicjalizacji na maksymalną wartość dla uint8.
    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: contract is initializing");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
            emit Initialized(type(uint8).max);
        }
    }
}
