// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

// interface IERC20 { ... } definiuje interfejs o nazwie IERC20. Interfejs w Solidity jest podobny do interfejsów w innych językach programowania; określa zestaw funkcji (bez ich implementacji), które inne kontrakty muszą zaimplementować. W tym przypadku określa funkcje wymagane dla tokenów ERC-20.
interface IERC20 {
    // event Transfer(address indexed from, address indexed to, uint256 value);
    // Definiuje zdarzenie, które jest emitowane, gdy tokeny są przenoszone z jednego adresu na inny. Możesz to porównać do powiadomienia bankowego o przelewie.
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Definiuje zdarzenie emitowane, gdy jedno adres zezwala innemu na wydawanie pewnej ilości tokenów w jego imieniu. To jak dając komuś pełnomocnictwo do korzystania z Twojego konta bankowego.
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // function balanceOf(address account) external view returns (uint256);
    // Pozwala sprawdzić ilość tokenów, które posiada dany adres. To jak sprawdzanie salda konta bankowego.
    function balanceOf(address account) external view returns (uint256);

    // function transfer(address to, uint256 amount) external returns (bool);
    //Umożliwia przesłanie określonej ilości tokenów na inny adres. To jak dokonanie przelewu bankowego.
    function transfer(address to, uint256 amount) external returns (bool);

    // Sprawdza, ile tokenów dany adres ma zezwolenie na wydanie z konta innego adresu. To jak sprawdzenie limitu na karcie kredytowej wydanej dla Ciebie przez kogoś innego.
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    // Umożliwia właścicielowi tokenów zezwolić innemu adresowi na wydanie określonej ilości swoich tokenów. To jak ustawianie limitu na wspomnianej karcie kredytowej.
    function approve(address spender, uint256 amount) external returns (bool);

    // Pozwala na transfer określonej ilości tokenów z jednego adresu na inny, ale tylko wtedy, gdy adres wykonujący transfer ma na to uprawnienia. To jak używanie karty kredytowej do zrobienia zakupu w imieniu kogoś innego.
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
