// SPDX - License - Identifier: UNLICENSED

pragma solidity ^0.8.9;

library Address {
    // Checks whether a given Ethereum address is a contract. On the Ethereum blockchain, addresses can belong to people or contracts. This function checks whether a given address contains a contract code.
    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    // It allows you to send Ether (Ethereum's currency) to another address. Requires the address from which funds are being sent to have enough Ether. If the transaction fails, the operation will be rolled back.
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    // Zestaw funkcji umożliwiających wywołanie funkcji innego kontraktu. Są one używane do interakcji z kontraktami, które nie są częścią aktualnie wykonywanego kontraktu.
    function functionCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    // Zestaw funkcji umożliwiających wywołanie funkcji innego kontraktu. Są one używane do interakcji z kontraktami, które nie są częścią aktualnie wykonywanego kontraktu.
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    // Te funkcje są podobne do powyższych, ale pozwalają również wysłać Ether razem z wywołaniem funkcji.
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    // Te funkcje są podobne do powyższych, ale pozwalają również wysłać Ether razem z wywołaniem funkcji.
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance fro call"
        );
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return verifyCallResult(success, returndata, errorMessage);
    }

    // Umożliwia wywołanie funkcji kontraktu, które nie mogą modyfikować stanu blockchain. Jest to używane do odczytywania danych z kontraktu bez możliwości ich zmiany.
    function functionStaticCall(
        address target,
        bytes memory data
    ) internal view returns (bytes memory) {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    // Umożliwia wywołanie funkcji kontraktu, które nie mogą modyfikować stanu blockchain. Jest to używane do odczytywania danych z kontraktu bez możliwości ich zmiany.
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    // Pozwala na wywołanie funkcji innego kontraktu tak, jakby była częścią kontraktu, który wykonuje to wywołanie. Jest to zaawansowana funkcjonalność i musi być używana ostrożnie, ponieważ może zmieniać stan kontraktu wywołującego.
    function functionDelegateCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    // Pozwala na wywołanie funkcji innego kontraktu tak, jakby była częścią kontraktu, który wykonuje to wywołanie. Jest to zaawansowana funkcjonalność i musi być używana ostrożnie, ponieważ może zmieniać stan kontraktu wywołującego.
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    // Weryfikuje wynik wywołania funkcji innego kontraktu. Jeśli wywołanie się powiodło, zwraca wynik. Jeśli nie, sprawdza, czy istnieje szczegółowy komunikat o błędzie zwrócony przez kontrakt i wywołuje błąd z tym komunikatem.
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
