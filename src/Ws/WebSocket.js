import { WebSocket } from "ws";

export function _readyState(webSocket) {
    return webSocket.readyState;
}

export function _create(address, protocols, options) {
    return new WebSocket(address, protocols, options);
}

export function _onOpen(webSocket, callback) {
    return webSocket.on("open", callback);
}

export function _close(webSocket, code, reason) {
    return webSocket.close(code, reason);
}

export function _onClose(webSocket, callback) {
    return webSocket.on("close", callback);
}

export function _onError(webSocket, callback) {
    return webSocket.on("error", callback);
}

export function _onMessage(webSocket, callback) {
    return webSocket.on("message", callback);
}

export const _send = (webSocket) => (data) => (options) =>
    function (onError, onSuccess) {
        webSocket.send(data, options, function (err) {
            if (err) {
                onError(err);
            } else {
                onSuccess();
            }
        });
        return function (cancelError, onCancelerError, onCancelerSuccess) {
            onCancelerSuccess();
        };
    };
