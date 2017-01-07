function [value_total, centroids, values]  = recognition_1(mask, img)
    %% static data

    SF = 0.0705;
    D_ref = [16.25; 18.75; 21.25; 19.75; 22.25; 24.25; 23.25; 25.75];
    % Gold -> Silver -> Copper
    C_ref = [208,148,87;152,131,113;194,124,94];
    C_ref_coef = [C_ref(:,2)./C_ref(:,1),C_ref(:,3)./C_ref(:,1)];
    m = regionprops(mask, 'EquivDiameter', 'Centroid');
    value_ref = [0.01; 0.02; 0.05; 0.10; 0.20; 0.50; 1.00; 2.00];

    %% Centroids
    centroids = cat(1, m.Centroid);

    %% Contour Diameter
    EquivDiameter = cat(1, m.EquivDiameter);
    D_MM = EquivDiameter.*SF;
    diameters = [];
    for i = 1:size(D_MM,1)
        D_diff = [];
        for j = 1:size(D_ref,1)
            D_diff = [D_diff; abs((D_MM(i)-D_ref(j)))];
        end
        cor = find(D_diff == min(D_diff));
        diameters = [diameters; cor];
    end
   
    %% Colors
    mask2 = imerode(mask, strel('disk', 40));
    [label,n] = bwlabel(mask2);
    r = double(img(:,:,1)); 
    g = double(img(:,:,2));
    b = double(img(:,:,3));
    colors_rgb = [];

    for i = 1:max(max(label))
        cor = find(label == i);
        color = [r(cor), g(cor), b(cor)];
        color = median(color);
        colors_rgb = [colors_rgb; color];
    end
    colors_coef = [colors_rgb(:,2)./colors_rgb(:,1),colors_rgb(:,3)./colors_rgb(:,1)];
    colors = [];
    % for i = 1:size(colors_coef,1)
    %     color_diff = [];
    %     for j = 1:size(C_ref,1)
    %         color_diff = [color_diff; sqrt(sum((colors_rgb(i,:)-C_ref(j,:)).^2))];
    %     end
    %     cor = find(abs(color_diff) == max(abs(color_diff)));
    %     colors = [colors; cor];
    % end
    for i = 1:size(colors_coef,1)
        color_coef_diff = [];
        for j = 1:size(C_ref_coef,1)
            color_coef_diff = [color_coef_diff; sqrt(sum((colors_coef(i,:)-C_ref_coef(j,:)).^2))];
        end
        cor = find(color_coef_diff == min(color_coef_diff));
        colors = [colors; cor];
    end
    % for i = 1:size(colors_coef,1)
    %     color_diff = [];
    %     for j = 1:size(C_ref,1)
    %         temp1 = sum((colors_rgb(i,:)-mean(colors_rgb(i,:))).*(C_ref(j,:)-mean(C_ref(j,:))));
    %         temp2 = sqrt(sum((C_ref(j,:)-mean(C_ref(j,:))).^2));
    %         color_diff = [color_diff; temp1./temp2];
    %     end
    %     cor = find(abs(color_diff) == max(abs(color_diff)));
    %     colors = [colors; cor];
    % end
    
    %% decision tree
    value_total = 0;
    values = zeros(size(diameters));
    for i = 1:size(diameters,1)
        if (colors(i) == 2) %silver
    %         values(i) = 1.00;
            if (D_MM(i) > 25)
                values(i) = 2.00;
            elseif (D_MM(i) > 24)
                values(i) = 0.50;
            elseif (D_MM(i) > 22.5)
                values(i) = 1.00;
            elseif (D_MM(i) > 21)
                values(i) = 0.20;
            else
                values(i) = 0.10;
            end
        elseif (colors(i) == 3) %copper
            if (D_MM(i) < 17.5)
                values(i) = 0.01;
            elseif (D_MM(i) > 20)
                values(i) = 0.05;
            else 
                values(i) = 0.02;
            end
        elseif (colors(i) == 1) %gold
            if (D_MM(i) > 25)
                values(i) = 2.00;
            elseif (D_MM(i) > 23.25)
                values(i) = 0.50;
            elseif (D_MM(i) > 21)
                values(i) = 0.20;
            else
                values(i) = 0.10;
            end
        end
    %     if (diameters_simp(i) == 5)
    %         values(i) = 2.00;
    %     elseif (diameters_simp(i) == 1)
    %         values(i) = 0.01;
    %     elseif (diameters_simp(i) == 2)
    %         if (colors_simp(i) == 2)
    %             values(i) = 0.10;
    %         elseif (colors_simp(i) == 1)
    %             values(i) = 0.02;
    %         end
    %     elseif (diameters_simp(i) == 3)
    %         if (colors_simp(i) == 2)
    %             values(i) = 0.20;
    %         elseif (colors_simp(i) == 1)
    %             values(i) = 0.05;
    %         end
    %     elseif (diameters_simp(i) == 4)
    %         if (colors_simp(i) == 2)
    %             values(i) = 0.50;
    %         else
    %             values(i) = 1.00;
    %         end
    %     end
    end
    value_total = sum(values);
    
end
