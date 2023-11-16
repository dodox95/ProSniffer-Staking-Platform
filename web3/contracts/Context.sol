// SPDX - License - Identified: UNLICENSED // SPDX - License - Identifier: UNLICENSED to komentarz określający licencję tego kontraktu. W tym przypadku UNLICENSED oznacza, że ten kod nie jest licencjonowany pod konkretną licencją open source. Jest to ważne dla określenia, jak inni mogą używać tego kodu.

// pragma solidity ^0.8.9; określa wersję kompilatora Solidity, którego należy użyć do kompilacji tego kontraktu. Symbol ^ oznacza, że kontrakt jest kompatybilny z wersjami Solidity 0.8.9 i nowszymi, ale poniżej 0.9.0.
pragma solidity ^0.8.9;

// tworzy abstrakcyjny kontrakt o nazwie Context. Abstrakcyjny kontrakt to taki, który nie może być wdrożony samodzielnie; służy jako szablon dla innych kontraktów, które go dziedziczą. Myśli się o tym trochę jak o szkielecie budynku, który określa podstawową strukturę, ale nie stanowi pełnego budynku.
abstract contract Context {
    // Ta funkcja jest wewnętrzną (internal), co oznacza, że może być wywoływana tylko wewnątrz tego kontraktu lub jego pochodnych. Zwraca adres nadawcy bieżącej wiadomości. W kontekście transakcji Ethereum, msg.sender jest adresem osoby (lub innego kontraktu), która wywołała funkcję. Jest to jak sprawdzenie ID osoby, która dzwoni do Ciebie.
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    // Podobnie jak _msgSender, ta funkcja jest wewnętrzna i zwraca dane wysłane w bieżącej wiadomości. W kontekście Ethereum, msg.data zawiera dane wejściowe do transakcji, czyli szczegółowe informacje o tym, co transakcja ma zrobić. Można to porównać do treści listu, który dostajesz.
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
