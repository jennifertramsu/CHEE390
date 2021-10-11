function v = part(v, left, right)

if left == right
    return
end

i = left;
pivot = right;
tmp = v(pivot);

while i < pivot
    
    while v(i) > tmp
        v(pivot) = v(i);
        v(i) = v(pivot - 1);
        v(pivot - 1) = tmp;
        pivot = pivot - 1;
    end
    
    i = i + 1;
    
end

v = part(v, left, pivot - 1);
v = part(v, pivot, right);

end
