function mask = segmentation_3(img)

    I = rgb2gray(img);

    % Detect Entire Cell
    [~, threshold] = edge(I, 'sobel');
    fudgeFactor = .45;
    BWs = edge(I,'sobel', threshold * fudgeFactor);

    % Dilate the Image
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);
    BWsdil = imdilate(BWs, [se90 se0]);
    for i = 4:2:10
        se = strel('disk',i);
        BWsdil = imclose(BWsdil, se);
    end
    BWsdil = bwareaopen(BWsdil,400,4);
    BWsdil = imclearborder(BWsdil, 8);

    % Fill Interior Gaps
    BWdfill = imfill(BWsdil, 'holes');

    % Remove Connected Objects on Border
    BWnobord = imclearborder(BWdfill, 4);

    %  Smoothen the Object
    seD = strel('diamond',1);
    BWfinal = imerode(BWnobord,seD);
    BWfinal = imerode(BWfinal,seD);
    BWfinal = imerode(BWfinal,seD);
    BWfinal = imerode(BWfinal,seD);
    BWfinal = imerode(BWfinal,seD);
    BWfinal = bwareaopen(BWfinal,400,4);

    mask = BWfinal;

end