#!/bin/bash

# Configuration
METRIC=2
K_START=3
K_END=8
TIMING_LOG="kmeans_metric_${METRIC}_timings_$(date +%Y%m%d_%H%M%S).csv"


# Initialize timing log
echo "filename,metric,k_value,time_ms" > "$TIMING_LOG"

# Function to get current time in milliseconds
current_time_ms() {
    echo $(($(date +%s%N)/1000000))
}

# Start total script timer
TOTAL_START=$(current_time_ms)

# Process files
find data/ -type f -name "*.bin" | while read -r INPUT_FILE; do
    base_name=$(basename "$INPUT_FILE" .bin)
    echo "Processing file: $INPUT_FILE"


    for ((K=K_START; K<=K_END; K++)); do
        echo "── Running K=$K ──"
        ITER_START=$(current_time_ms)
        
        CENTROIDS_FILE="results/kmeans_k-${K}_metric-${METRIC}_${base_name}_centroids.txt"
        LABELS_FILE="results/kmeans_k-${K}_metric-${METRIC}_${base_name}_labels.txt"
        
        ./build/cluster -p -G 0 -K "$K" -D "$METRIC" "$INPUT_FILE" "$CENTROIDS_FILE" "$LABELS_FILE"

        ITER_END=$(current_time_ms)
        ITER_TIME=$((ITER_END - ITER_START))
        echo "$base_name,$METRIC,$K,$ITER_TIME" >> "$TIMING_LOG"
        echo "⏱️  K=$K took ${ITER_TIME}ms"
    done
done

# Final summary
TOTAL_END=$(current_time_ms)
TOTAL_TIME=$((TOTAL_END - TOTAL_START))
echo "Total runtime,$TOTAL_TIME" >> "$TIMING_LOG"
echo "✅ Total runtime: ${TOTAL_TIME}ms"
echo ""
echo "Timing data saved to: $TIMING_LOG"