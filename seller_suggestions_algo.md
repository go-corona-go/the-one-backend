# Suggestions Algorithm for WFTO Covid

## Goals and Non Goals

*Goals*
- Provide best effort suggestions/recommendation to the WFTO admin on which sellers to choose to fulfill the order.
- Consider recency of order for a seller, his location and capacity for suggestions.

*Non Goals*
- Performance is not of paramount need here.

## Criteria for order fulfillmet and High Level Idea

1. Prioritize the local(within country) vendors to fulfill the complete order.

2. For any order item, there can be at max 3 local sellers who will be fulfilling the order.

3. If required only 1 seller from outside the country will be chosen who meets capacity and closest to the buyer.

## Algorithm

1. An order can have many different items, first choose the item with the maximum requested units.

2. Get all the local sellers for the item sorted by last order time(ASC).

3. Take 1st seller check if capacity total matches the order requirement. If yes then go to second item. If no take second seller capacity and add to first one, if still does not fulfill add third.

4. After having 3 seller which are still not able to fullfil the capacity, we start getting a new seller and dropping one of the old sellers from our set of 3 based on following criteria :

    1.   Take the 4th seller from the sorted list and check if its capacity > min(existing 3). If no ignore seller 4.

    2. If yes check if we drop seller 3(most recent of the 3) and add seller 4 does our requirement met if yes choose 1,2,4.

    3. If no then remove the seller with the least capacity and add seller 4 to the list.

    4. So here we will always maintain 2 list of 3 sellers one sorted by asc order of last order received and one by asc order of capacity. Always try to prioritize seller with oldest order time.
    5. Repeat the steps until we have 3 sellers who fulfill the requirement or we will have 3 sellers with max capacity if even they are also not able to fulfill the order.

5. If even after step 4, the local sellers are not able to fulfill the order, the remaining units(order units - units from local sellers) need to be fulfilled by a large foriegn seller. We will select a single foreign seller whose capacity > remaining and is closest to the buyer based on distance(store lat/long for each seller and buyer).

6. Now pick the item with second most units. 
    1. Here first check the number of units which can be availed from the local buyers chosen in step 4. 
    2. Run the Steps 2-5 again for item 2. If foreign seller is again needed first check if seller in Step 5 meets the need. If yes choose him, else repeat step 5 to find a new buyer.

7. Similarly keep picking the items and applying Steps 2-6.
8. After we have list of all the sellers for each item, that becomes are candidate set for our order.
9. This list should already be optimized as we already consider seller of a previous item in next item.
