function W = get_proj_op(W,UB)

    if ~isempty(UB)
        W = sign(W).*min(abs(W),UB);
    end

end