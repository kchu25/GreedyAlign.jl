mat_complement(mat::Matrix{T}) where T <: Real = reverse(mat);

str2indicatormat(str) = reduce(hcat, [atcg2dummy[s] for s in str])
countmat(strs; ps=1f0) = sum(str2indicatormat.(strs)) .+ ps
countmat_sumcol(count_matrix) = sum(count_matrix, dims=1)
countmat2pfm(count_matrix, countmat_sum_col; S=float_type, ps=1f0) = 
    S.((count_matrix .+ ps) ./ (countmat_sum_col .+ (4*ps)));
countmat2pfm(count_matrix; ps=1f0) = 
    countmat2pfm(count_matrix, sum(count_matrix, dims=1); ps=ps)

freq2pwm(pfm, float_type; b=[.25,.25,.25,.25]) = 
    float_type.(log2.(pfm ./ b))

get_code_non_zero_components(Z) = Z[1:4:end,:,:];

function percentile_thresh_Z_nz(Z_nz; percentile= 0.0055)
    Z_nz_sorted = sort((@view Z_nz[:]))
    ind = Int(round(length(Z_nz_sorted) * (1.0 - percentile)))
    return Z_nz_sorted[ind]
end
    
function get_strs(data, pos, k)
    strs = Vector{String}()
    for (range_, n) in pos[k]
        push!(strs, data.raw_data[n][range_])
    end
    return strs
end

function get_strs(data, pos_ki)
    strs = Vector{String}()
    for (range_, n) in pos_ki
        push!(strs, data.raw_data[n][range_])
    end
    return strs
end

function get_strs_ignore_out_of_range(data, pos_ki)
    strs = Vector{String}()
    for (range_, n, use_comp) in pos_ki
        if (range_[1] > 0 && range_[end] ≤ data.L) 
            if use_comp
                push!(strs, dna_comp(data.raw_data[n][range_]))
            else
                push!(strs, data.raw_data[n][range_])
            end
        end
    end
    return strs
end

# function get_strs(data, pos, k)
#     strs = Vector{String}()
#     for (range_, n) in pos[k]
#         push!(strs, data.raw_data[n].str[range_])
#     end
#     return strs
# end

# function get_strs(data, pos_ki)
#     strs = Vector{String}()
#     for (range_, n) in pos_ki
#         push!(strs, data.raw_data[n].str[range_])
#     end
#     return strs
# end

# function get_strs_ignore_out_of_range(data, pos_ki)
#     strs = Vector{String}()
#     for (range_, n, use_comp) in pos_ki
#         if (range_[1] > 0 && range_[end] ≤ data.L) 
#             if use_comp
#                 push!(strs, dna_comp(data.raw_data[n].str[range_]))
#             else
#                 push!(strs, data.raw_data[n].str[range_])
#             end
#         end
#     end
#     return strs
# end
