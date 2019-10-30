function [RV,C,I,RI,d] = decVAT(RV,C,I,RI,d,point_to_remove)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    point_to_remove_index=find(I==point_to_remove);
    removed_points_associates_index=[];
    for j=1:length(point_to_remove_index)
        removed_points_associates_index=[removed_points_associates_index find(C(2:end)==point_to_remove_index(j))+1];
    end
    removed_points_associates=I(removed_points_associates_index);
    
    if(isempty(removed_points_associates))
        I(point_to_remove_index)=[];
        
        C(point_to_remove_index)=[];
        index=find(C>point_to_remove_index);
        C(index)=C(index)-1;
        
        d(point_to_remove_index-1)=[];
        
        RV(point_to_remove_index,:)=[];
        RV(:,point_to_remove_index)=[];
        
        [~,RI]=sort(I);
    else
        I_old=I;
        
        if(point_to_remove==I_old(1))
            remaining_points=I(3:end);
            remaining_points_old_points_method=remaining_points;
            remaining_points_location_in_RV=3:length(RV);
            remaining_points_old_points_method_location_in_RV=remaining_points_location_in_RV;
            included_old_points=[];
            included_old_points_location_in_RV=[];
            pointer_last_point=2;
            d_remaining=d(2:end);
            C_remaining=C(3:end);

            I=I(2);
            d=[];
            RV_reordering=2;
            C=1;
            [~,idx]=find(removed_points_associates==I);
            removed_points_associates(idx)=[];
            removed_points_associates_index(idx)=[];
        else
            remaining_points=I(point_to_remove_index+1:end);
            remaining_points_old_points_method=remaining_points;
            remaining_points_location_in_RV=point_to_remove_index+1:length(RV);
            remaining_points_old_points_method_location_in_RV=remaining_points_location_in_RV;
            included_old_points=[];
            included_old_points_location_in_RV=[];
            pointer_last_point=point_to_remove_index;
            d_remaining=d(point_to_remove_index:end);
            C_remaining=C(point_to_remove_index+1:end);

            I=I(1:point_to_remove_index-1);
            d=d(1:point_to_remove_index-2);
            RV_reordering=1:point_to_remove_index-1;
            C=C(1:point_to_remove_index-1);
        end
        for k=1:length(remaining_points)
            if(~isempty(removed_points_associates))
                if(remaining_points_old_points_method(1)==removed_points_associates(1))
                    dist_remaining_points=RV(RV_reordering,remaining_points_location_in_RV);
                    [len,~]=size(dist_remaining_points);
                    if(len==1)
                        [min_dist_remaining_points,index1]=min(dist_remaining_points);
                        closest_point_index_remaining_points=remaining_points_location_in_RV(index1);
                        closest_point_remaining_points=I_old(remaining_points_location_in_RV(index1));
                        %closest_point_C_index_remaining_points=RV_reordering(1);
                        closest_point_C_index_remaining_points=ismember(I_old(RV_reordering(1)),I);
                    else
                        [value,index]=min(dist_remaining_points);
                        [min_dist_remaining_points,index1]=min(value);
                        closest_point_index_remaining_points=remaining_points_location_in_RV(index1);
                        closest_point_remaining_points=I_old(remaining_points_location_in_RV(index1));
                        [~,closest_point_C_index_remaining_points]=ismember(I_old(RV_reordering(index(index1))),I);
                    end
                    
                    if(ismember(closest_point_remaining_points,removed_points_associates))
                        I=[I closest_point_remaining_points];
                        d=[d min_dist_remaining_points];
                        C=[C closest_point_C_index_remaining_points];
                        RV_reordering=[RV_reordering closest_point_index_remaining_points];
                        remaining_points(remaining_points==closest_point_remaining_points)=[];
                        remaining_points_location_in_RV(remaining_points_location_in_RV==closest_point_index_remaining_points)=[];
                        
                        if(closest_point_remaining_points==removed_points_associates(1))
                            remaining_points_old_points_method(remaining_points_old_points_method==closest_point_remaining_points)=[];
                            remaining_points_old_points_method_location_in_RV(remaining_points_old_points_method_location_in_RV==closest_point_index_remaining_points)=[];
                            pointer_last_point=pointer_last_point+1;
                            d_remaining(1)=[];
                            C_remaining(1)=[];
                            if(length(remaining_points_old_points_method)>0)
                                while(ismember(remaining_points_old_points_method(1),I))
                                    pointer_last_point=pointer_last_point+1;
                                    d_remaining(1)=[];
                                    C_remaining(1)=[];
                                    remaining_points_old_points_method(1)=[];
                                    remaining_points_old_points_method_location_in_RV(1)=[];
                                    
                                    if(length(remaining_points_old_points_method)==0)
                                        break;
                                    end
                                end
                            end
                        end
                        [~,idx]=find(removed_points_associates==closest_point_remaining_points);
                        removed_points_associates(idx)=[];
                        removed_points_associates_index(idx)=[];
                        
                    else
                        I=[I closest_point_remaining_points];
                        d=[d min_dist_remaining_points];
                        C=[C closest_point_C_index_remaining_points];

                        included_old_points=[included_old_points closest_point_remaining_points];
                        included_old_points_location_in_RV=[included_old_points_location_in_RV closest_point_index_remaining_points];

                        RV_reordering=[RV_reordering closest_point_index_remaining_points];
                        if(~isempty(closest_point_remaining_points))
                            remaining_points(remaining_points==closest_point_remaining_points)=[];
                            remaining_points_location_in_RV(remaining_points_location_in_RV==closest_point_index_remaining_points)=[];
                        end
%                         remaining_points(remaining_points==closest_point_remaining_points)=[];
%                         remaining_points_location_in_RV(remaining_points_location_in_RV==closest_point_index_remaining_points)=[];
                    end
                else
                    min_dist_old_points=d_remaining(1);
                    closest_old_points=remaining_points_old_points_method(1);
                    closest_old_points_location_RV=remaining_points_location_in_RV(1);
                    [~,closest_point_C_remaining_old_points]=ismember(I_old(C_remaining(1)),I);

                    dist_included_old_points=RV(included_old_points_location_in_RV,remaining_points_location_in_RV);
                    if(length(included_old_points_location_in_RV)==1)
                        [value1,index1]=min(dist_included_old_points);
                        [~,closest_point_C_included_old_points]=ismember(included_old_points,I);
                    else
                        [value,index]=min(dist_included_old_points);
                        [value1,index1]=min(value);
                        [~,closest_point_C_included_old_points]=ismember(included_old_points(index(index1)),I);
                    end
                    min_dist_included_old_points=value1;
                    closest_included_old_points_location_RV=remaining_points_location_in_RV(index1);
                    closest_included_old_points=remaining_points(index1);

                    if(isempty(min_dist_included_old_points))
                        min_dist_all=min_dist_old_points;
                        min_dist_method=1;
                    else
                    [min_dist_all,min_dist_method]=min([min_dist_old_points Inf min_dist_included_old_points]);
                    end

                    switch min_dist_method
                        case(1)
                            I=[I closest_old_points];
                            d=[d min_dist_old_points];
                            C=[C closest_point_C_remaining_old_points];
                            RV_reordering=[RV_reordering closest_old_points_location_RV];
                            remaining_points(remaining_points==closest_old_points)=[];
                            remaining_points_old_points_method(remaining_points_old_points_method==closest_old_points)=[];
                            remaining_points_old_points_method_location_in_RV(remaining_points_old_points_method_location_in_RV==closest_old_points_location_RV)=[];
                            remaining_points_location_in_RV(remaining_points_location_in_RV==closest_old_points_location_RV)=[];
                            pointer_last_point=pointer_last_point+1;
                            d_remaining(1)=[];
                            C_remaining(1)=[];
                            if(length(remaining_points_old_points_method)>0)
                                while(ismember(remaining_points_old_points_method(1),I))
                                    pointer_last_point=pointer_last_point+1;
                                    d_remaining(1)=[];
                                    C_remaining(1)=[];
                                    remaining_points_old_points_method(1)=[];
                                    remaining_points_old_points_method_location_in_RV(1)=[];
                                    if(length(remaining_points_old_points_method)==0)
                                        break;
                                    end
                                end
                            end
                        case(2)
                            printf('Error')
                            break;
                        case(3)
                            I=[I closest_included_old_points];
                            d=[d min_dist_included_old_points];
                            C=[C closest_point_C_included_old_points];
                            if(closest_included_old_points==remaining_points(1))
                                if(length(remaining_points_old_points_method)>0)
                                    while(ismember(remaining_points_old_points_method(1),I))
                                        pointer_last_point=pointer_last_point+1;
                                        d_remaining(1)=[];
                                        C_remaining(1)=[];
                                        
                                        included_old_points(included_old_points==remaining_points_old_points_method(1))=[];
                                        included_old_points_location_in_RV(included_old_points_location_in_RV==remaining_points_old_points_method_location_in_RV(1))=[];

                                        remaining_points_old_points_method(1)=[];
                                        remaining_points_old_points_method_location_in_RV(1)=[];

                                        if(length(remaining_points_old_points_method)==0)
                                            break;
                                        end
                                    end
                                end
                            else
                                included_old_points=[included_old_points closest_included_old_points];
                                included_old_points_location_in_RV=[included_old_points_location_in_RV closest_included_old_points_location_RV];
                            end
                            RV_reordering=[RV_reordering closest_included_old_points_location_RV];
                            
                            if(~isempty(closest_included_old_points))
                                remaining_points(remaining_points==closest_included_old_points)=[];
                                remaining_points_location_in_RV(remaining_points_location_in_RV==closest_included_old_points_location_RV)=[];
                            end
                    end
                end
            else
                min_dist_old_points=d_remaining(1);
                closest_old_points=remaining_points_old_points_method(1);
                closest_old_points_location_RV=remaining_points_location_in_RV(1);
                [~,closest_point_C_remaining_old_points]=ismember(I_old(C_remaining(1)),I);

                dist_included_old_points=RV(included_old_points_location_in_RV,remaining_points_location_in_RV);
                if(length(included_old_points_location_in_RV)==1)
                    [value1,index1]=min(dist_included_old_points);
                    [~,closest_point_C_included_old_points]=ismember(included_old_points,I);
                else
                    [value,index]=min(dist_included_old_points);
                    [value1,index1]=min(value);
                    [~,closest_point_C_included_old_points]=ismember(included_old_points(index(index1)),I);
                end
                min_dist_included_old_points=value1;
                closest_included_old_points_location_RV=remaining_points_location_in_RV(index1);
                closest_included_old_points=remaining_points(index1);

                if(isempty(min_dist_included_old_points))
                    min_dist_all=min_dist_old_points;
                    min_dist_method=1;
                else
                [min_dist_all,min_dist_method]=min([min_dist_old_points Inf min_dist_included_old_points]);
                end

                switch min_dist_method
                    case(1)
                        I=[I closest_old_points];
                        d=[d min_dist_old_points];
                        C=[C closest_point_C_remaining_old_points];
                        RV_reordering=[RV_reordering closest_old_points_location_RV];
                        remaining_points(remaining_points==closest_old_points)=[];
                        remaining_points_old_points_method(remaining_points_old_points_method==closest_old_points)=[];
                        remaining_points_old_points_method_location_in_RV(remaining_points_old_points_method_location_in_RV==closest_old_points_location_RV)=[];
                        remaining_points_location_in_RV(remaining_points_location_in_RV==closest_old_points_location_RV)=[];
                        pointer_last_point=pointer_last_point+1;
                        d_remaining(1)=[];
                        C_remaining(1)=[];
                        if(length(remaining_points_old_points_method)>0)
                            while(ismember(remaining_points_old_points_method(1),I))
                                pointer_last_point=pointer_last_point+1;
                                d_remaining(1)=[];
                                C_remaining(1)=[];
                                remaining_points_old_points_method(1)=[];
                                remaining_points_old_points_method_location_in_RV(1)=[];
                                
                                if(length(remaining_points_old_points_method)==0)
                                    break;
                                end
                            end
                        end
                    case(2)
                        printf('Error')
                        break;
                    case(3)
                        I=[I closest_included_old_points];
                        d=[d min_dist_included_old_points];
                        C=[C closest_point_C_included_old_points];
                        if(closest_included_old_points==remaining_points(1))
                            if(length(remaining_points_old_points_method)>0)
                                while(ismember(remaining_points_old_points_method(1),I))
                                    pointer_last_point=pointer_last_point+1;
                                    d_remaining(1)=[];
                                    C_remaining(1)=[];

                                    included_old_points(included_old_points==remaining_points_old_points_method(1))=[];
                                    included_old_points_location_in_RV(included_old_points_location_in_RV==remaining_points_old_points_method_location_in_RV(1))=[];

                                    remaining_points_old_points_method(1)=[];
                                    remaining_points_old_points_method_location_in_RV(1)=[];

                                    if(length(remaining_points_old_points_method)==0)
                                        break;
                                    end
                                end
                            end
                        else
                            included_old_points=[included_old_points closest_included_old_points];
                            included_old_points_location_in_RV=[included_old_points_location_in_RV closest_included_old_points_location_RV];
                        end
                        RV_reordering=[RV_reordering closest_included_old_points_location_RV];
                        if(~isempty(closest_included_old_points))
                                remaining_points(remaining_points==closest_included_old_points)=[];
                                remaining_points_location_in_RV(remaining_points_location_in_RV==closest_included_old_points_location_RV)=[];
                        end
                end
            end
        end
        RV=RV(RV_reordering,RV_reordering);
        [~,RI]=sort(I);
    end
end

