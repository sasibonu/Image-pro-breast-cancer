clear all
camera = webcam;
nnet = googlenet;
inputSize = nnet.Layers(1).InputSize(1:2);
h = figure;

while ishandle(h)
    im = snapshot(camera);
    image(im)
    im = imresize(im,inputSize);
    [label,score] = classify(nnet,im);
    title({char(label), num2str(max(score),2)});
    drawnow
end