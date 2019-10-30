function [RV,C,I,RI,d,new_point_location] = incVAT(RV,C,I,RI,d,distance_previous_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    I_old=I;
    C_old=C;
    new_point_index=length(I)+1;
    new_point_location=length(I)+1;
    for j=1:length(I)-1
        [value,index]=min(distance_previous_points(1:j));
        %d(j)
        if(value<d(j))
            new_point_location=j+1;
            break;
        else
            [~,index]=min(distance_previous_points);
        end
    end
    %new_point_location
    %C
    remaining_points=I(new_point_location:end);
    remaining_points_old_points_method=remaining_points;
    remaining_points_location_in_RV=new_point_location:length(RV);
    remaining_points_old_points_method_location_in_RV=remaining_points_location_in_RV;
    included_old_points=[];
    included_old_points_location_in_RV=[];
    pointer_last_point=new_point_location-1;
    d_remaining=d(new_point_location-1:end);
    C_remaining=C(new_point_location:end);
    
    I=[I(1:new_point_location-1) new_point_index];
    d=[d(1:new_point_location-2) min(distance_previous_points(1:new_point_location-1))];
    RV_reordering=1:new_point_location-1;
    C=[C(1:new_point_location-1) index];
    
    method=[];
    for k=1:length(remaining_points)
        %start_point=1
        min_dist_old_points=d_remaining(1);
        closest_old_points=remaining_points_old_points_method(1);
        closest_old_points_location_RV=remaining_points_location_in_RV(1);
        [~,closest_point_C_remaining_old_points]=ismember(I_old(C_remaining(1)),I);

        dist_new_point=distance_previous_points(remaining_points_location_in_RV);
        [min_dist_new_point,index]=min(dist_new_point);
        closest_new_point_location_RV=remaining_points_location_in_RV(index);
        %closest_new_point=remaining_points(closest_new_point_location_RV-new_point_location+2);
        closest_new_point=remaining_points(index);
        closest_point_C_remaining_new_point=new_point_location;

        included_old_points;
        included_old_points_location_in_RV;
        remaining_points;
        remaining_points_location_in_RV;
        dist_included_old_points=RV(included_old_points_location_in_RV,remaining_points_location_in_RV);
        if(length(included_old_points_location_in_RV)==1)
            [value1,index1]=min(dist_included_old_points);
            %closest_point_C_included_old_points=included_old_points_location_in_RV;
            [~,closest_point_C_included_old_points]=ismember(included_old_points,I);
        else
            [value,index]=min(dist_included_old_points);
            [value1,index1]=min(value);
            %closest_point_C_included_old_points=remaining_points_location_in_RV(index(index1));
            [~,closest_point_C_included_old_points]=ismember(included_old_points(index(index1)),I);
        end
        min_dist_included_old_points=value1;
        closest_included_old_points_location_RV=remaining_points_location_in_RV(index1);
        closest_included_old_points=remaining_points(index1);
        %[~,closest_point_C_included_old_points]=ismember(I_old(C_remaining(1)),I);

        if(isempty(min_dist_included_old_points))
            [min_dist_all,min_dist_method]=min([min_dist_old_points min_dist_new_point]);
        else
        [min_dist_all,min_dist_method]=min([min_dist_old_points min_dist_new_point min_dist_included_old_points]);
        end

        switch min_dist_method
            case(1)
                method=[method 1];
                I=[I closest_old_points];
                d=[d min_dist_old_points];
                C=[C closest_point_C_remaining_old_points];
                %included_old_points=[included_old_points closest_old_points]
                %included_old_points_location_in_RV=[included_old_points_location_in_RV closest_old_points_location_RV]
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

                        %included_old_points(included_old_points==closest_old_points)=[];
                        %included_old_points_location_in_RV(included_old_points_location_in_RV==closest_old_points_location_RV)=[];
                        if(length(remaining_points_old_points_method)==0)
                            break;
                        end
                    end
                end
            case(2)
                method=[method 2];
                I=[I closest_new_point];
                d=[d min_dist_new_point];
                C=[C closest_point_C_remaining_new_point];
                if(closest_new_point==remaining_points(1))
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
                    included_old_points=[included_old_points closest_new_point];
                    included_old_points_location_in_RV=[included_old_points_location_in_RV closest_new_point_location_RV];
                    %remaining_points_old_points_method(remaining_points_old_points_method==closest_new_point)=[]
                    %remaining_points_location_in_RV(remaining_points_location_in_RV==closest_new_point_location_RV)=[]
                end
                RV_reordering=[RV_reordering closest_new_point_location_RV];
                remaining_points(remaining_points==closest_new_point)=[];
                remaining_points_location_in_RV(remaining_points_location_in_RV==closest_new_point_location_RV)=[];
            case(3)
                method=[method 3];
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
                    %remaining_points_old_points_method(remaining_points_old_points_method==closest_included_old_points)=[]
                    %remaining_points_location_in_RV(remaining_points_location_in_RV==closest_included_old_points_location_RV)=[]
                end
                RV_reordering=[RV_reordering closest_included_old_points_location_RV];
                remaining_points(remaining_points==closest_included_old_points)=[];
                remaining_points_location_in_RV(remaining_points_location_in_RV==closest_included_old_points_location_RV)=[];
        end
%         if(~isequal(remaining_points,remaining_points_old_points_method))
%             remaining_points
%             remaining_points_old_points_method
%         end

    end

    %d=[d(1:new_point_location-2) min(distance_previous_points) d(new_point_location-1:end)]
    
    RV_old=RV;
    RV=RV(RV_reordering,RV_reordering);
    %row_to_insert=[distance_previous_points(1:new_point_location-1) 0 distance_previous_points(new_point_location:end)]
    row_to_insert=distance_previous_points(RV_reordering);
    row_to_insert=[row_to_insert(1:new_point_location-1) 0 row_to_insert(new_point_location:end)];
    RV=[RV(1:new_point_location-1,1:new_point_location-1) (row_to_insert(1:new_point_location-1))' RV(1:new_point_location-1,new_point_location:end);row_to_insert;RV(new_point_location:end,1:new_point_location-1) (row_to_insert(new_point_location+1:end))' RV(new_point_location:end,new_point_location:end)];
    [~,RI]=sort(I);
    
    
end

